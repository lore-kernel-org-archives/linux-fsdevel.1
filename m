Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56563A900B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560931; cv=fail; b=Rfi8A612YuJgYRpfBeCd8eKMbnsPfRY7pveeo3Q7puycPU+rNnYuPMwNV+fHnfU/U42ARANcD4dsJjim3N7rAzfL0mOs4Vg1K1lAArxGXj+jhF9dkfTLqojMX97xvMa3UdrZ0zq69/Y9D6rcbnf0PEBj/eyTvHgpytH1WK4M+Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560931; c=relaxed/simple;
	bh=J5QiYaN9E4+nRG4VPVbH909ja4pvM1tEWfHPbvyP1TQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBqfcQa2Q54CloOsJO7TNmhpH1NLqEdXDOHmsnI4vKRDqGvCboBuljosblrAKAL6ITkSbJjnGo3OOnwMkzqmwpzNZ8Xb8hcM7YPv5rJAk9PV29Rm6bx97LNR45524OpwuVcwROFxH/ZlnWbmQEvl/qM3n557xK3nxK2j44AnbdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=TPO/ITts; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="TPO/ITts"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022089.outbound.protection.outlook.com [40.107.200.89]) by mx-outbound45-95.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:35:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BU3HorAVR5YqbssOLjltsAtWxFtAbtkKV42Q9//B8k6/lvM1uA0uFHY2hwwESzSVC1Y2IA0NgOoXYgPlQswdN9ktC74aqHLZvA7XkAwz6A9kiCNjVb/JT2eAUFkf1LHMQ9fpA6FTaefLYBfGvKgMm9dnuQihNfb9h6VfWSHJPsCE1mjpM/Bullxcm/Y41OtVXnad635nWWwZwLAvS6/Ul/pUKKSOOhRUdUzTJPUJEkU/SE9dT0MQHZ1notFNrwyZ9TU3f/VNIPwPmNnJ2VohUM3FbcBHmhIPwdU8EAOrTde1rbJgX13x47XkYrIAicQ4vZVVKXq72TGull7tUk14Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfFdz8VSbMdEUrqIsgj/rNC4un+guNfklM/L235TaUM=;
 b=WIGWWF+tE+cYiJ+VE12PCHkdvFpLVJBqVpWXbF9mSa4AR860lx7ndxXCXOcHc6/rHZwX8vCmXXVAAUPZnWLVZOqc7Ox3MvEDjmDk4psVu8CJ6u+ySpnij7ryPSS+Z0S/r7cIgNSO1PmVIUAeoUNNBLJnCecR0Fy5JXWCqEofa25wK9byHwiYeB4XeCCE6s87f6c79h+N3/aXOoJaVp6IS8Mzd7jFJfL2cxN+ZGwAzfJjs+a9TjnWFro1UoLEZjSQwXrImTdEIfut+/4unTq83A37KpkK0l3iAQQJtNOVuUmz27ceEDXsQQp07Q6opOIpYt8+YWQQ5Bl+KNs9Bf3X1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfFdz8VSbMdEUrqIsgj/rNC4un+guNfklM/L235TaUM=;
 b=TPO/ITtskLmf2D91npWJ5FtN67xOyZWzo+LqhSwZjIHww5I8RiwhIe1AoUWUifw12SQMRLQAJOHu2MCv1hpIzhpBNrPR1XNLXF3MyhhCWANqSpB7WG1TFgm+letaRaiXKFIogLZfsgdYaO4YxhT+pqiAiOOt/wLfZ5L/zeLZTas=
Received: from SJ0PR03CA0385.namprd03.prod.outlook.com (2603:10b6:a03:3a1::30)
 by SA1PR19MB5038.namprd19.prod.outlook.com (2603:10b6:806:186::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:35:18 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a5) by SJ0PR03CA0385.outlook.office365.com
 (2603:10b6:a03:3a1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 21:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:35:16 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id EAA26179;
	Thu, 26 Mar 2026 21:35:15 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Date: Thu, 26 Mar 2026 22:34:58 +0100
Subject: [PATCH v2 25/25] Add a background debug option to passthrough hp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-fuse-init-before-mount-v2-25-b1ca8fcbf60f@bsbernd.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560892; l=3527;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=J5QiYaN9E4+nRG4VPVbH909ja4pvM1tEWfHPbvyP1TQ=;
 b=ZL5FndgSbd0CE/433lzYQmZ3Qiv2eSaiTnGjZ+HYgwolRPYh0wE7ysZtpMtIDVGY/mPUsPGEf
 7HQ6zp4+LrMADY8IGD6vQ4nDaQQ5ZxsFUuCHKBYPelUoyGy1iPGYQSW
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|SA1PR19MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1122d3-9637-4422-e318-08de8b7f928c
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|48200799018|19092799006|82310400026|61400799027|13003099007|18002099003|56012099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	dkLujgEE4xxN70ktruTqHfVrESiBzCvytLY+kzwCL2bqzITVJhC/VokBhTqekMzjtB3iB5o3MXjN1U9UTqZ+L1fcotlau+40a7aNWFyCM8sg461rrSe5NZ0D3g4ShcKzrJQdu5VzEIGYegxyJ4K9/EnTH/Fcq0uytMtdRHPBSsQ+X9NOpQ2EM0S/jTkvpQzcSfH3VO9kiqN/otGJpXQmb1q9tAjHiNkiLI++W/nlecA2M/BNYuDt4+KbcGIsCXOznijJWi2ZXT2qN+fk3+LvMadPVMPol5a9v++j/QlDM+3IlY/nd7JrnU+S4fmgG5djCSAO/x5EpqcAkP9TPB2sRWrBAqpaDRWgjII3gboXLnw+abfuN5Mxk3Dslkt7EBexlcvDicn4NhjxMA3ubSE6/C0+ylJVsNXtwsABaRcTy70xKixN2jDGztTr75VR3KBLYoJO6+Z5HUJSk41/UTqDwsLY8PBrVUc7Gcb2SrClQVHUivJIrP5E7y3o8Yplm3bltSyV514PKxF+Yi7lPJaL68GI4KqjFIzC/7rqLeO61nRnkMNFbMb7rTyv0DeBWOZNB2ki61gfYAGls/ulgP80c0ffmwETLODhFcctq/LoH/nMO7p9sNkmIzO4E9tzov20il4DoOafbCwIYk0Cy9UdAM8oQBDNR+HFnnJO0zXI3ajII8+0fpQc4+wvKkEaq2JXR2JKH0CGMm7bmCW3Qi8Rx0YlqUh96YMLiC997B6IJlvBdYTzGyJM/pzsp3sgmZR2pthTF4JBdjj8P56Ie3dyMg==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(48200799018)(19092799006)(82310400026)(61400799027)(13003099007)(18002099003)(56012099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iNDNQjTN3DyVpCdRCdIKtcX6IwqUSOnWeROSS2lbPu7c064lpDI9wUJVO/Mhp3Ao2D1OdE1mxxSepAc5QD25iotN7MlXyePE/vVLdANTuv7P3tnHsJbhOCD7eBW5NgCk5YDEziA9dgC3ZjdNEzhxAhHTnHZbauw/r66/iTqk89e/0J3SRC67Dk18VzRTUhp75Wm+XNdRHcP63CIu7L3mnY5tFaPkRwhUyfQPotPvfBecFmHtmt0aJzY9z9jaBxHDaQnXBquyvxZl7IBeLsR0VG3MCLhdkN/T1tzrElmk2qTFiXLBlsqKWiV2ryD89/fraZeFGUyDIuUWCJVHzMI3t/LsDTyostuv6dGxujlzWu/Ayj16OlrnYW3xt7+H0saY5h6IhxwZ5wDRZ3nm0b30z/qPfED3nG8vps2dSCWAzqWCwFNFJwmqQTDUxrG5wvYS
X-Exchange-RoutingPolicyChecked:
	ryH26zTAtkSwQFe8fMw1ELVf8oZ6TKm0wwAl1NqSl11k5hySzXIPVA7qZLFAGRrezAfTrnkd13+QaT3GcofsI5CStDqqGA6WVzMsM32DZaXKQuPQ7KeQSlqHzov0RzwsCCgWDWPUI27zcrlLe47WrtfE8e9aRT5boB5MqdSRFi2D+qE1yI1lcZDaLyF4Aatk8un9b5MAAjy7qi58l/i1doSdTP76N932BBs7ZFEbnI06AbNib7725lzMEGdlcYB54yBqoBlfEIokbcWHFMkGkBr2rZ+otbdHgkxOWlOflg4eZ4tr6ChX3/6QrmPcCcidZHcGXxqZO3RUq9TW3w0r5w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uWIjL03AKCcSl2/KhI6LL5WmkvlfMgZuvLsOAV1YkpNpSqQCbHeDqe17dqGrY1tnVQcX4t2IpnlW93T29gK+vGfpPZuN1faO/rF2DTkJ0C0HZu2tZUjb4l5wkmoJAFyrgPbq8XqV+OqOhhI2/yag7QrTImq2mobzSJktbyW5W92tI0kD6fE44rUkCLoxOwuzA+JRntMDqYQ3uFG+k59MyMIso8ZkUkdMFrqliKPEi4VvPuEAoK82SQ6NblhN9ShhkOztMLTXZxGeQYx3K215up4bxjuKlpkRONN2D7u0/eP5Uj4qiAVY9YrzOUDndolrj0fjkPVXmXUYp/tI5wzUF9rakbO3hmOoLC9gYYEI9TRz0CLHKBjZg/n7T0Wyr+jrguxGMFqTdQ8UV8wvcKa7YZA8WXf52JdI6COLhkbSs83RyFrHXmp/Pf/gTG/GsRmr2r+ISwZD10UoTPUITnApUn3kEaXsnIEAIwzT/L4Qu6G4I0DwjPNMIsR6RtWS4LUXGqrK0F7ojsQUQ8Tre+mlKwB1yphPgtQY9x9Dcdi2C94HGYTIw9Lgj5oP+AK0tWg20KmMSWjxh2G1lFXoPLH9YgtT7Nit7x6b8S/6DTWNueIDMUWinZsbJa0J3qVINrZDSfQE8jFjlnye7Vd36sYXjQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:16.8080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1122d3-9637-4422-e318-08de8b7f928c
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB5038
X-BESS-ID: 1774560922-111615-7723-3332-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 40.107.200.89
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYmJiZAVgZQMMXA0sg8zcIw2c
	wk2cjM0sDYwMjYMsXQ2Dw50djEyCRJqTYWANqMfuVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan20-24.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Background debugging is useful when logs should go
to syslog for a daemon running in background.

Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
---
 example/passthrough_hp.cc | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/example/passthrough_hp.cc b/example/passthrough_hp.cc
index cca865973ab5e8e9c1faa0fa28eb292a172a4812..fa924b89ab3cc42a88767423674a6a190c0aa520 100644
--- a/example/passthrough_hp.cc
+++ b/example/passthrough_hp.cc
@@ -160,7 +160,8 @@ struct Fs {
 	Inode root;
 	double timeout;
 	bool debug;
-	bool debug_fuse;
+	bool debug_fuse; // foreground fuse debug
+	bool bg_debug_fuse; // background fuse debug
 	bool foreground;
 	std::string source;
 	size_t blocksize;
@@ -1480,21 +1481,22 @@ static cxxopts::ParseResult parse_options(int argc, char **argv)
 {
 	cxxopts::Options opt_parser(argv[0]);
 	std::vector<std::string> mount_options;
-	opt_parser.add_options()("debug", "Enable filesystem debug messages")(
-		"debug-fuse", "Enable libfuse debug messages")(
-		"foreground", "Run in foreground")("help", "Print help")(
-		"nocache", "Disable attribute all caching")(
-		"nosplice", "Do not use splice(2) to transfer data")(
-		"nopassthrough", "Do not use pass-through mode for read/write")(
-		"single", "Run single-threaded")(
-		"o",
-		"Mount options (see mount.fuse(5) - only use if you know what "
-		"you are doing)",
-		cxxopts::value(mount_options))(
-		"num-threads", "Number of libfuse worker threads",
-		cxxopts::value<int>()->default_value(SFS_DEFAULT_THREADS))(
-		"clone-fd", "use separate fuse device fd for each thread")(
-		"direct-io", "enable fuse kernel internal direct-io");
+	opt_parser.add_options()
+		("debug", "Enable filesystem debug messages")
+		("debug-fuse", "Enable libfuse debug messages")
+		("bg-debug-fuse", "Enable libfuse debug messages in background")
+		("foreground", "Run in foreground")("help", "Print help")
+		("nocache", "Disable attribute all caching")
+		("nosplice", "Do not use splice(2) to transfer data")
+		("nopassthrough", "Do not use pass-through mode for read/write")
+		("single", "Run single-threaded")
+		("o", "Mount options (see mount.fuse(5) - only use if you know what "
+		      "you are doing)",
+		cxxopts::value(mount_options))
+		("num-threads", "Number of libfuse worker threads",
+		cxxopts::value<int>()->default_value(SFS_DEFAULT_THREADS))
+		("clone-fd", "use separate fuse device fd for each thread")
+		("direct-io", "enable fuse kernel internal direct-io");
 
 	// FIXME: Find a better way to limit the try clause to just
 	// opt_parser.parse() (cf. https://github.com/jarro2783/cxxopts/issues/146)
@@ -1520,6 +1522,7 @@ static cxxopts::ParseResult parse_options(int argc, char **argv)
 
 	fs.debug = options.count("debug") != 0;
 	fs.debug_fuse = options.count("debug-fuse") != 0;
+	fs.bg_debug_fuse = options.count("bg-debug-fuse") != 0;
 
 	fs.foreground = options.count("foreground") != 0;
 	if (fs.debug || fs.debug_fuse)
@@ -1643,6 +1646,12 @@ int main(int argc, char *argv[])
 
 	fuse_loop_cfg_set_clone_fd(loop_config, fs.clone_fd);
 
+	if (!fs.foreground)
+		fuse_log_enable_syslog("passthrough-hp", LOG_PID | LOG_CONS,
+				       LOG_DAEMON);
+	if (fs.bg_debug_fuse)
+		fuse_session_set_debug(se);
+
 	/* Start daemonization before mount so parent can report mount failure */
 	if (fs.foreground)
 		daemon_flags |= FUSE_DAEMONIZE_NO_BACKGROUND;

-- 
2.43.0

