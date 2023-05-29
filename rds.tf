#Create RDS database subnet group
resource "aws_db_subnet_group" "LandmarktechRDSsubnetgroup" {
    name       = "labvpcrdssubnetgroup"
    subnet_ids = [aws_subnet.PrivateSubnet3.id, aws_subnet.PrivateSubnet4.id]
    description = "Subnet group for RDS"
    tags = {
        Name = "labvpcrdssubnetgroup"
    }
}

#Create RDS Amazon Aurora cluster
resource "aws_rds_cluster" "LabVPCDBCluster" {
    cluster_identifier = "labvpcdbcluster"
    engine = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.07.2"
    db_subnet_group_name = aws_db_subnet_group.LandmarktechRDSsubnetgroup.name
    database_name = "Population"
    master_username = "admin"
    master_password = "testingrdscluster"
    vpc_security_group_ids = [aws_security_group.LandmarktechRDSSG.id]
    apply_immediately = true
    skip_final_snapshot = true
}

#Create RDS Amazon Aurora cluster instance - Multi AZ
resource "aws_rds_cluster_instance" "LabVPCDBInstances" {
    count = 2
    identifier = "labvpcdbcluster-${count.index}"
    cluster_identifier = aws_rds_cluster.LabVPCDBCluster.id 
    engine = aws_rds_cluster.LabVPCDBCluster.engine
    engine_version = aws_rds_cluster.LabVPCDBCluster.engine_version
    instance_class = "db.t3.small"
    publicly_accessible = false
    db_subnet_group_name = aws_db_subnet_group.LandmarktechRDSsubnetgroup.name
} 