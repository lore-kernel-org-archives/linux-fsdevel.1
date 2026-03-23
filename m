Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868A2C2374
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287934; cv=fail; b=cB8sSKo37FSl9cfPVsD5fNemkyWmRPmALBANpbLg2X7WJesShwbjAgjZexFyKxjaDOTlMO/a6O9ldo2cj7S3MgChG7i6r+pw0SmAyh55LmIpZ4hsieeQPj7KhkDVxrOQa91FF1fPletwyHOFKV5i2mPjB7l9vggfbqqNYjKkXvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287934; c=relaxed/simple;
	bh=bJaHaRP35JkQQry4rwSyCQaWjrzYTE8MQM3WIehz8fA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ta+b7iRvXsnvl2pzccQp3jlrbu/jGuyMp3VnG4HHBYixAhOkWG/DXa/eK/7wVBNZPoj7azG8pzq28iOLnlA/7bukTMBp2GBKu89t9ROYK/jXGC34JWgxsNHIqz/TAuHHZiuGzfAq03IuW9lyERluX0zAxxi4ZorHnKs5zFi/t40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=ilgjK7cG; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="ilgjK7cG"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022119.outbound.protection.outlook.com [40.107.209.119]) by mx-outbound17-33.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Mar 2026 17:45:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHPJPQJqqpZUQtjMh5ZyL+be1FYuc9cPsqpvINbDDy4rE5evHph4gK6RGua5LRPVJkf4VPbJqb4I+xWB6ZLlz5nV+Kk+Xk/MHCbCT0HNJ/XB2JDXd7J0SMRecWC6Op50FPGNv1c6l/aEwQsky6yb+OBS5DFC43WRVegCciWxgy2LxLiMCMWiQNQ1X2ghvySgH7mv4+A9caHvqDPaAVbxhkbC7hNWJLTk1XPw5Eo+G3jie7s3LZ56gwbW1i3RYk/938+QBI3mI8EdQMZ/ZQvRSlxMCG1pE4h+fN1fy9cZ3vYmg6aUTwXrzIJlGWFpj39qsMraJJFp1X83ofHVntSd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yfoa7DArbYXWSlbdaKhuwnLmT92xHeKMfNEOVgB2nW0=;
 b=JiPEuw+SjHosJs4FHR1jb3B7mii2ntq0FinqYd2x78QfkogjM9nra4pK4piB0IqV+2aRFjogCGo1roq/HmqYJlJvIjIfGydG2JNJLgc0khhClmVZD8xfk5cwlOKfKS7jJAJj4Hd1MdgFsj0YV3yRbGRFbfKWF/pHOzGIqyVqTaA7X2GjwasCfbw2sJx6yeg86kCX5AjBRWpzMEUo1wRzgpjWwJekk4c+/mA3brRFj6d4aRCD0ikAMvTNpS+zl+1//is+yNbn/+gyr95rvQxm6Brh33btUvS+P/4/p9/85ISWjj7RgUYuG89+NR0zhloKRfSy6cjSsO1rE/gerUABpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfoa7DArbYXWSlbdaKhuwnLmT92xHeKMfNEOVgB2nW0=;
 b=ilgjK7cGTzt3GeXXTRmb7tBsNnT7rPqcZE8RTPqEUG8Z20kLWMLQK7bzaIEkoj50HcTMVkl/+WCr1LkI5kzYAJKN3ShH4vZ8Zyr/VoQlnRFv67752wB4U5MvLoskA+l9MISd0y3kodICWJV/uXC1zRa2EPnHk7a6F+3BGOvPhIk=
Received: from DS7P220CA0071.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::18) by
 SA1PR19MB8949.namprd19.prod.outlook.com (2603:10b6:806:46b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:45:09 +0000
Received: from DS2PEPF000061C4.namprd02.prod.outlook.com
 (2603:10b6:8:224:cafe::45) by DS7P220CA0071.outlook.office365.com
 (2603:10b6:8:224::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 17:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 DS2PEPF000061C4.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 17:45:08 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id D43BBB7;
	Mon, 23 Mar 2026 17:45:03 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH 00/19] libfuse: Add support for synchronous init
Date: Mon, 23 Mar 2026 18:44:55 +0100
Message-Id: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABh8wWkC/x2MQQqAIBAAvxJ7bkGNovpKdLDarT2koRlB9Pek4
 wzMPBApCEXoiwcCXRLFuwy6LGDerFsJZckMRplGVaZCTjE7JydOxD4Q7j65E1uuJ9VZbWfWkOM
 jEMv9j4fxfT8sf6KpaAAAAA==
X-Change-ID: 20260323-fuse-init-before-mount-8f5b09a1acf1
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774287905; l=4024;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=bJaHaRP35JkQQry4rwSyCQaWjrzYTE8MQM3WIehz8fA=;
 b=LWNqibzRUK1amlyxdyCtHn9gY44B2DppHG/NDArzxqnhPJnc6ME+IHIjtua9xDY6rD0S32MnJ
 tWqC44AhK61DCC7S5FY0+poOE3s5JVT2lKApJEuKoYOfR7H1pNuy28E
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C4:EE_|SA1PR19MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e09dcf-890a-44ac-fd1d-08de8903ecf5
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|48200799018|36860700016|61400799027|82310400026|19092799006|376014|7053199007|18002099003|16102099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8v4pilCdJEWu2yfVV1p8owU+VeltDADIpiAOlI9qnHcezD0D+Rvb2+katgQOsFGjGQg8wC10FDL4QQNNQjS5BnL+6lvI2CRBaJxTtbEPU46QzlCuqhhWEbKqEfSBbXzO6dyS8ZneRHSr1BEDKbxRGIjuqwQ+W759QCRom4yoZKTotRl+LGdCzIQz3PkxEa1PeOGv522j8jDpAoapJZ00MFp7KRDFeHfYoTnKPMQ1Tj1xbu0Nq+WiWl+ApP+nRNKDUVrcYKK9rCHaOSb/Q0ELRpjbWeSEqA2NjTVPJTmr/6V9Pq7E+2auERzBcpVJ9xjztv06S7fcy71sb6kR9Gs95YL5GsCjrLzvqeefgvV8fCPp7yXw6Vib69maOUzwVCJC2oxJ3Q6i8hlPO1XhZphZIEBgVKpG6ALAa01FBf9QFn+JY3yb33NX8AHC+a7NKSOxvVPKqopp2lp40envPbIuElX82+ItgKSOcm7Kw7+OjJ2LWgZarjcKU98/WPSImmptXaLvl1GSJh1xcK4ys9hwwszBY9EaUHu3KgZz3CNmm29awdjiRJcBAV71ix/g5gLm1qVLEj6ip8RNSrJS71t+UW16tnJl9qs9sIchDaQT4qCWiAp0oZCy5Dnc66GUbucBAN5Qe7SO9Ggulbef/4Nt5byXVis2tlFoUi/ZxxgSQmYgjCCunBA3oKfR/xFYlmyziEPXLG3oyU7ll/+bICW5ZuEnjJWcpcmRIuh8rTNUPEUABfwLmEo2ZWwLVhfcF4gXI0ZPCgfTr6O5sKOY42pyrw==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(48200799018)(36860700016)(61400799027)(82310400026)(19092799006)(376014)(7053199007)(18002099003)(16102099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PPpIkFVB1hi4kyvLBd+JVkqdPZVFWA/Jvudf+4FiBq6lDNWOYdRxBXOWovuvH4SnLVnCZr1kmBVt0mBtt0uGoCg6yI2fhmDn5Avif7lLmubo5hHyXn1ktDi6+XLCwBDQ53M5j8LRwUI69PFFWnInVmTx6gss/xOTczoPxhoEmdbqO3hNvKfa13+hgTtpH4mnmHE5r4Dr6/o4QxVnH6TFUBUdm+9TMTvu3ISTjW01UUuSYFIgcX27R3483V+GZI7koArugZVWOr9DT3EiKPek2+U3Bwa9+IAewsRbMlTzbL2jDFHPp5KqsZfsOsfv2PlpeSK/mIHRCttHCNjWTFFYPr7Z0BQ2ksBQ1BfrtLngHglz0/FJ0BZUo2kGtzzV23nl+aK2JWc41DnPy9oGIjxC8dOqaiBC8FtoQHAS+ghWV2mzjhGwhcXQj4XGCeTWxsLB
X-Exchange-RoutingPolicyChecked:
	i9bBVZw5YRGs/C3aoIfMw0bx6v4MZTO47iaSaVlo5M21EcumhV1Os5k3chrAQNmKo4FKH+A2LJsU5CpWJpJCU8IPzgkxQHV7yKCx+9Q5ZYzWmtM+rXpuJHhd8SjGHuPJUpV96eMK9qrEGC8Cxxcj4HexaeDu2VJ38I3QaiTSihgBd38XR/KS7IDmQ75e6jCe4I7P3rDpIlNKYwAEuzQ4BdD8/1WoJ/7ho5+TJO3Fvn88h69bqLwCwgJMrLPaCXdkCi8xaj1e5WdlgJT5986GieHvJkgHiWDgF0y7KyCZxqXrkPRR6At1ThgZR30rS1mMQpHGsUE0tYwTM9eKDWcO0Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nb7A5KhYLRVervcuid5F6XAx31WaqzOG7YT9X3fsQTziCYh4FknpgbqDokwr6RgA1NgA+0Tv4kvUsro98wNbPKoBYgXSSGjIrB/PPOcqwCPx+QtNGjFvtuI+g6+td4ttA9QErS4EqYV12cHUe7+TaAPOy02h33iTusA42X1rAn2iT8RU5wnbVCro8YjctPfpZgBjlk6/NGR5qMYfGh0/150VfSrgqS/KWb00Bp5w1T0t+afybJEGJQXvGCqlO7IOYom4FFyvIFkkcgyfa1+K6WJ0gjwUFnh9yBoWYYXnUsluNQkIgoorFatMt4zhavuuVPlI0Y1WnRcG0dEYcFcctqrCSLj8x70+PJpKPfu2YzefEYbk7SGxtOH9LKxZUeNwdwrQO1ipRmrO2dKQDbmAPAM64w60Yf6UTvCXU2nqCDtLljcKSR5LsG1vzr5p9m6ZN5LCxIoWWlqTVcGG+fuM2BtRYn3KM4SkHquwKHNK/Xf8/UY6/26e5DMWuGNDJn5VXYFoq7XNZq9YzKApmIUFSEHlATJSsvJVh6mmYte1PQNMSbwQFzRFmKxCAOrhBd24vyZdDMufofVoEJCsj4QjUEvvvtcGGT8/Ixjd1kN/Geu0KBOXCJMzBZHkzz0ewO2yUMVGWyaelpfKvOyBVWdiEQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:45:08.5661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e09dcf-890a-44ac-fd1d-08de8903ecf5
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8949
X-BESS-ID: 1774287913-104385-12416-20343-1
X-BESS-VER: 2019.1_20260319.1837
X-BESS-Apparent-Source-IP: 40.107.209.119
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaWxqZAVgZQMMXCyMDILNkwKc
	kwydDSKNEgxcgszSA5KcnCwtDUwjRVqTYWAJUpTtBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272017 [from 
	cloudscan17-12.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

I'm taking Darricks example here and posting API changing libfuse
changes to linux-fsdevel. We should consider to create a fuse
specific list if that is too much. The existing
fuse-devel@lists.sourceforge.net is rather hopeless due to lack
of spam filtering.

The first few patches in this series are just preparation, after that
follow the important parts:

1) New daemonize API, see that commit for details. In short, the existing
fuse_daemonize() was not sufficient for complex daemons and is impossible
to use with sync-init and the current way to start fuse-io-uring ring
threads.

2) Support for privileged daemons, still rather straight forward, but
requires the startup of a worker thread that handles requests until
mount is complete.

3) Privileged daemons - requirement is to update the API with fusermount,
because fuse_session_mount_new_api() needs to obtain the /dev/fuse file
descriptor, then start the worker thread with that fd and then continue
the actual mount through fusermount.

To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Joanne Koong <joannelkoong@gmail.com>

Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
---
Bernd Schubert (19):
      ci-build: Add environment logging
      Add 'STRCPY' to the checkpatch ignore option
      checkpatch.pl: Add _Atomic to $Attribute patttern
      Add a new daemonize API
      Sync fuse_kernel.h with linux-6.18
      mount.c: Split fuse_mount_sys to prepare privileged sync FUSE_INIT
      Add FUSE_MOUNT_FALLBACK_NEEDED define for -2 mount errors
      Refactor mount code / move common functions to mount_util.c
      Move mount flags to mount_i.h
      conftest.py: Add more valgrind filter patterns
      Add support for the new linux mount API
      fuse mount: Support synchronous FUSE_INIT (privileged daemon)
      Add fuse_session_set_debug() to enable debug output without foreground
      Move more generic mount code to mount_util.{c,h}
      Split the fusermount do_mount function
      fusermount: Refactor extract_x_options
      Make fusermount work bidirectional for sync init
      New mount API: Filter out "user="
      Add support for sync-init of unprivileged daemons

 .github/workflows/checkpatch.yml |   2 +-
 checkpatch.pl                    |   3 +-
 doc/README.daemonize             | 186 +++++++++++
 doc/README.fusermount            | 359 +++++++++++++++++++++
 doc/README.mount                 |  86 +++++
 doc/README.sync-init             | 184 +++++++++++
 example/passthrough_hp.cc        |  18 +-
 include/fuse_daemonize.h         |  71 +++++
 include/fuse_kernel.h            |   1 +
 include/fuse_lowlevel.h          |  24 ++
 include/meson.build              |   3 +-
 lib/fuse_daemonize.c             | 292 +++++++++++++++++
 lib/fuse_i.h                     |  27 +-
 lib/fuse_lowlevel.c              | 342 +++++++++++++++++++-
 lib/fuse_versionscript           |   4 +
 lib/helper.c                     |  13 +-
 lib/meson.build                  |   6 +-
 lib/mount.c                      | 380 +++++++++++++++-------
 lib/mount_bsd.c                  |   1 +
 lib/mount_common_i.h             |  29 ++
 lib/mount_fsmount.c              | 417 ++++++++++++++++++++++++
 lib/mount_i_linux.h              |  87 +++++
 lib/mount_util.c                 |  34 ++
 lib/mount_util.h                 |  11 +
 meson.build                      |  19 +-
 test/ci-build.sh                 |  16 +
 test/conftest.py                 |   7 +-
 test/test_want_conversion.c      |   1 +
 util/fusermount.c                | 671 +++++++++++++++++++++++++++++++--------
 util/meson.build                 |   2 +-
 30 files changed, 3024 insertions(+), 272 deletions(-)
---
base-commit: 9eba0f3c9e8b5af7b252093bb6f81f086bb35563
change-id: 20260323-fuse-init-before-mount-8f5b09a1acf1

Best regards,
-- 
Bernd Schubert <bernd@bsbernd.com>

