Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CFD39EF3D
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560918; cv=fail; b=IGXJB06c6FZiuYQP9yHIcoLEj8DCfwrKorP2Q3LD+cQkDJYz3k++yZHvxkjhJD01RRGKF56Hp9EQ4pOXVMEcZZ6NVN6F8XdYucAHmLPyJKlLM/2YSo75NysGTHAUMbK2p2hESSSXJTcNvnirSWY2JXmyfSyfcBZ1wx/gHBX9FXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560918; c=relaxed/simple;
	bh=L4msO8x0Eo8xZjQj0t9SaYGiBfq+n+4pdVd0n7uSD2Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DeTGfn2wJhvi3Cckou5IsnH0WyOzfQ2Rsw1KSFL7qroKYcOVRONJK0I3cF18zo/rQgEVfTPAVJDovq7F1Uqip+F2jruAztqs7qUZaj2qVlnmEsuftISdYRSZalKZUlVxh2Hn4oh1MHQIeorzVFuz3nrFUeZ0P2SsZCcYh+Q5zYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b=XRNyF91m; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadirectnetworks.onmicrosoft.com header.i=@datadirectnetworks.onmicrosoft.com header.b="XRNyF91m"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020122.outbound.protection.outlook.com [52.101.193.122]) by mx-outbound45-95.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Mar 2026 21:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+g1lzaEUxCJShvBNJeEfwczW61b03uAie12nnDP3AhERmF6CNU8Jfg+nYzvn6CYyVfxh66DQPMsiFIhDCA4DAqDlTkL5D0yT2ipgi7UG1yBSJp3TiLeJ3utS49aUODPJDcbdfs+iq1HpxZXwpLLZyy61OHw9zN2a7WJQcuPp4ACiQNHfAPZAllNj7rx5F2eoKk3pu9vTCCOWVTDXPhJ8XjagDPd4evSnmk8+3MdO+GZX4OM//EnYnzGxzbSZ7hJmKaC70kfiVzzcfr7a2YB6VPRUUcmFhBbXVruhOHC7DBPEuM4341K5eDWNO4QC1b9t9zMeyH85Q1o8vmWv1ycrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvLzVSLU9yoEBOLFAfeJEdrU6SI11ny46XfXhdoypUk=;
 b=V/7Gdgn9Ubg1ReYfUvmuBp56i8NoezIKoNWsByof+kB0p6tBxYfQL+bEDz9gaTzLDmzHchk4GRywSfa4ZUmjWIoo9FIJXlfl2Br/p6h3/eQPH1DvhGzu+RThCzSHoOdNDKS4OvQ6pFhFC0Nhllgu3fWV52OmwV4r8VoA8ejiQXhWv4/KMktvNfnIGi62awkeFoep2UQFyapimvGo5rGxgKS4NkVhVZwoUUgEvADBwF1OctIthojFta6wPmfCh5Z47mUFdD2+VoH2va10bFVYv6c8InLc2NJRtcr3dJvUcERa/TN+OpBiqVirDvQFRgbfe28jZbccoe1b4Rr+iaSLRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bsbernd.com smtp.mailfrom=ddn.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=bsbernd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=datadirectnetworks.onmicrosoft.com;
 s=selector2-datadirectnetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvLzVSLU9yoEBOLFAfeJEdrU6SI11ny46XfXhdoypUk=;
 b=XRNyF91mjtKLDetGEaLTVDe+x/yee9/aw6po8s041aS8ESUR16ttz+XkWEXYPjQBhz+LJKY2t12NjW/Ucrn/wGR+py39nAAxl2MCgxTRdg/WoN4SEW5LvQUIk5d1KUXdCh2UontsfZjbnwZ86CNGL24zQaspBUULL1DT8+rmOWA=
Received: from MN2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:208:23c::30)
 by BN0PR19MB5312.namprd19.prod.outlook.com (2603:10b6:408:157::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 21:34:53 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::6f) by MN2PR18CA0025.outlook.office365.com
 (2603:10b6:208:23c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 21:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=bsbernd.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 21:34:53 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 404BB8FD;
	Thu, 26 Mar 2026 21:34:52 +0000 (UTC)
From: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v2 00/25] libfuse: Add support for synchronous init
Date: Thu, 26 Mar 2026 22:34:33 +0100
Message-Id: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGmmxWkC/4WNQQ7CIBBFr9LM2jFAbWNdeQ/TBdDBzqJggBJN0
 7uLvYDL95L//gaJIlOCW7NBpMKJg6+gTg3YWfsnIU+VQQnVi1a16NZUneeMhlyIhEtYfcar64w
 YtNTWSajjVyTH7yP8GCvPnHKIn+OnyJ/9mywSBepOTa24CO364W6Soeinsw0LjPu+fwHw5c59v
 gAAAA==
X-Change-ID: 20260323-fuse-init-before-mount-8f5b09a1acf1
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
 Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774560891; l=5624;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=L4msO8x0Eo8xZjQj0t9SaYGiBfq+n+4pdVd0n7uSD2Q=;
 b=6xXr1/lT2F8UkU8ngbcSVo0D8ye4f9Qwdnyew03E/L7W1TTqhdNUiFFF5uXx9JiJ4bGhkZfY2
 m8l9cjKt3SNABZYZkIbM8yhWRh+nDpRuGDqXoO7QEo10wvKlw5hANb/
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|BN0PR19MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d68fba-c0b0-4372-3b96-08de8b7f84a0
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|36860700016|48200799018|82310400026|19092799006|18002099003|56012099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	vQrxMbu2TYtqcFdtK+qP1dhmm/v14XwpKv/XSTdMbYFpVVs4Le8Qndf4ajguDNiTLcIVt/dtk8KuNnknHksYk5BDSk9NRm7HXxYaU3hdbjKfm2VroTzw+FYo0IS78WgW9hHm5ZGByfeM8dms2n6e2qMP+UwwxsDGcg179RNTjBlDLsLySFHf86AyQ7ttC88Kpg3lysNDfHmhfjlEkE3xc1dPRSdxUlBa9D9l07HJyRIAxoSn/ZUHRT4hrcwez72AAQft/GUVzRfBg81URjYherpbIwu/1AWNtWmxG9FI9Co6KAVEXUWeB+rCZZ1Obljt5NWctbtvewWhbGhz5odigZKrzDYbC7KueDcxmk9gDT8xUVBUKjRlUFqmkLUxYuD+b9GvrhFflnTd6RvgGNwOPxNvNTkmrRgE/PbtgF4q/YirrAoeCBVIOll+YfKncHtvxAF4cC+HnZ7SIIX6GbYiVIywVN8u7s3xlXXWW423lAc137u898jSoUiprtL2b5C7bvveGvyDZOEuit/czRttGngW5jcZ4PLqb9seuekq9ECdyGTJkVpWRll+7w1/a/Yp9qH+0/wS1L8nP7u3nWRm4YVHSoPx0wt45qRx4hcoNJ3W1DLJrGFg8XaMfukAvYeU0Dtbc2HFKpOWJA6hhnpDmyQoeyG5huMM/0fhyhr2DGMhaY3NbwjUMg49ZVQNkaBuL0afOZ1WTkSJ1b60ruWL3POUu19eWGo6bXjn2b8oSPoB0s8Hrj8xOD1d8IPsLhB8IodxNE7uebDDpWujNTWIhQ==
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(61400799027)(36860700016)(48200799018)(82310400026)(19092799006)(18002099003)(56012099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7EH9KrvJCW2q4rl9oZT6AdKf/YepdwSHesjdZ4ZxyfF3HrygkKYYcHnC0FWR6bOEwg2rUH2zWwX/FDbTrl5JjBX3MtiTLY06Dygy/iNxh6HanDdGTDI1ZfeJzKgmjvLCx2MxwoZLyiDSTwIYlMrmafgzfRoA/17yAtgxo7vct/KVoxCCJQAfTReFncRvyn28c37ZRfGVV3m9kc+fFk1oFJFgDTzyLcluMhN4ZhLy9aDECbc4bEi1z3I9VvDOmhwhCjL7XSr0AHXIz7Tqy1osZyfAk8K2p74lkCJpbN1+njhXYkf8aVWk0yAnH4rFDoDUiUQamOSH9NTGFN5gFTh/TAyTxlBKB5/uj8lNxJK8uSF0Rp3tlTatqoKOzzGSJczKskLZrUiQpRiOygLk4hU59rAbIds6UwbhuABMUl59BYQdDFNHY9OpzxxRVrov7lLG
X-Exchange-RoutingPolicyChecked:
	vF5KN+nRHS2Gp4NUn0jo9DjmKUnGJBVsPltQUYJvlSx8QNYTzTv9xWxrv567hh+0vyYIsVGcoVroZ9sAamcEjKie+yeIYFKD0UntB0OxFHxBlnRf9niK6/pSK2MC9Widnzp8OlE/ODgTKJvca4mp2jeZ+zZT2D6wTyJNotkqAvxomLtITfnvjp9eAemghTR08hHV0sRo799BV0fDoMRRrtPttfA53QZAb6ZcGRLauf1TI8M1eSqJrl4psHTHEJKqK0mK+NWo0cA20as54Nru+ejGtK4ehVqZGJeL7uD2WIJregh8EP7tHRYv+62OlPm9ASqV59ztX7CHp3y6yBjg2g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p4xXGbGLTFKLRIIqkCcS1RFYu/f3E6cHvE35N2CZp+FW6GDC/FC6qyOJK0uvVB9Ut1fFc903zpS/4n3D7l9wJ1m4McHVTMz97LPDz69ORbAJZMMslgzm/Q+feI0MVYjbd8ct82DjE23wAeFhFr04aOHuLaEQKxfwjO4tZ3QnqTT3BFYNnUMDy/XLWfL+pOyZW9ZMzv1jVMncbcSQiOOZFWP/T+uDOzzkeSBkszVKMsVNl97BnZxcwJXvDi2s9iEqQfvubIwsZ6ySxTzLqs2YNcL+48xGMUob+Jt1y8oP/bDc2LosBOWrgnKm4BI+mli6wJDp+ymYPyRCuPyedQLI1UIwowzLPC1SMsgOTJImgq48w24YPUbHNOK99xqBOFdE3efUT61cB1023T7RiYmavqeWb35JHJyEV7QimLUQXmJObDcFIRCIkXRd5z35gi5vIUUYRkVr/VyjSBG1JLQsesRMouyF5HjVl78x0cdrJe9LLyNyZdMY3wYHxJqThC8E55MCAyZiGgCgeZ5qzTCkTBuMA7zwcGWvBF/9CCT/nxsTJ8XXsUg2d4eMXbJUt0WEyBIiXqZU7Bos7rcCbnfiAuvGvBkW2WOgu5zWgREk6fzSMirfalZxo1l/hWLy8S7foZKrUvYmH/wcOpPaELcR7A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:34:53.3892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d68fba-c0b0-4372-3b96-08de8b7f84a0
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR19MB5312
X-BESS-ID: 1774560898-111615-9802-3180-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 52.101.193.122
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqamBmZAVgZQ0Dwx2cTYOCXN0N
	jMxCwx0cjcIiXRPMko1TLNMtXAzDJJqTYWAJOvibVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272096 [from 
	cloudscan16-172.us-east-2b.ess.aws.cudaops.com]
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
Cc: Kevin Chen <kchen@ddn.com>
Joanne Koong <joannelkoong@gmail.com>

Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
---
Changes in v2:
- Fixed review comments from Darrick (thanks a lot for the review)
- Fixing some review comments required quite some restructuring
  to handle BSD (like using an include in fusermount.c for
  fuse_kern_fsmount()
- fuse_mnt_build_{source,type} are moved from mount.c to
  mount_util.c and also not using struct mount_opts anymore -
  fusermount.c and mount_fsmount.c can now use these functions
- A rather important change for fuse_daemonize_success(), it needs
  to be called from fuse_lowlevel_ops::init() and after fuse_session_mount(),
  it will figure out itself which of these two calls will actually signal
  success to the parent - depends on if sync or async FUSE_INIT is used.
- fuse_daemonize.c used a static variable for the state object 
  instead of dynamically allocated. Especially with latest additions to
  handle sync init correctly there were too many races. I consider to 
  change that file to C++ or Rust in the future to get reference count
  pointer to self destruct the object.
- The new doc/READMEs are in their own commit now
- Link to v1: https://lore.kernel.org/r/20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com

---
Bernd Schubert (25):
      ci-build: Add environment logging
      Add 'STRCPY' to the checkpatch ignore option
      checkpatch.pl: Add _Atomic to $Attribute patttern
      Add a new daemonize API
      Sync fuse_kernel.h with linux-6.18
      mount.c: Split fuse_mount_sys to prepare privileged sync FUSE_INIT
      Add FUSE_MOUNT_FALLBACK_NEEDED define for -2 mount errors
      Refactor mount code / move common functions to mount_util.c
      Use asprintf() for fuse_mnt_build_{source,type}
      lib/mount.c: Remove some BSD ifdefs
      Move 'struct mount_flags' to util.h
      conftest.py: Add more valgrind filter patterns
      Add support for the new linux mount API
      fuse mount: Support synchronous FUSE_INIT (privileged daemon)
      Add fuse_session_set_debug() to enable debug output without foreground
      Move more generic mount code to mount_util.{c,h}
      Split the fusermount do_mount function
      fusermout: Remove the large read check
      fusermount: Refactor extract_x_options
      Make fusermount work bidirectional for sync init
      New mount API: Filter out "user="
      Add support for sync-init of unprivileged daemons
      Move fuse_mnt_build_{source,type} to mount_util.c
      Add mount and daemonization README documents
      Add a background debug option to passthrough hp

 .github/workflows/checkpatch.yml |   2 +-
 checkpatch.pl                    |   3 +-
 doc/README.daemonize             | 197 ++++++++++++
 doc/README.fusermount            | 362 ++++++++++++++++++++++
 doc/README.mount                 |  86 ++++++
 doc/README.sync-init             | 184 +++++++++++
 example/passthrough_hp.cc        |  62 ++--
 include/fuse_daemonize.h         |  91 ++++++
 include/fuse_kernel.h            |   1 +
 include/fuse_lowlevel.h          |  32 ++
 include/fuse_mount_compat.h      |   5 +
 include/meson.build              |   3 +-
 lib/fuse_daemonize.c             | 304 ++++++++++++++++++
 lib/fuse_i.h                     |  27 +-
 lib/fuse_lowlevel.c              | 351 ++++++++++++++++++++-
 lib/fuse_versionscript           |   5 +
 lib/helper.c                     |  13 +-
 lib/meson.build                  |   6 +-
 lib/mount.c                      | 354 +++++++++++++--------
 lib/mount_bsd.c                  |   2 +
 lib/mount_common_i.h             |  29 ++
 lib/mount_fsmount.c              | 462 ++++++++++++++++++++++++++++
 lib/mount_i_linux.h              |  51 +++
 lib/mount_util.c                 | 119 ++++++-
 lib/mount_util.h                 |  25 ++
 meson.build                      |  19 +-
 test/ci-build.sh                 |  16 +
 test/conftest.py                 |   7 +-
 test/test_want_conversion.c      |   1 +
 util/fusermount.c                | 649 +++++++++++++++++++++++++++++----------
 util/meson.build                 |   2 +-
 31 files changed, 3137 insertions(+), 333 deletions(-)
---
base-commit: 9eba0f3c9e8b5af7b252093bb6f81f086bb35563
change-id: 20260323-fuse-init-before-mount-8f5b09a1acf1

Best regards,
-- 
Bernd Schubert <bernd@bsbernd.com>

