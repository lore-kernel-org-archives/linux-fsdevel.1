Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98637CD20;
	Mon, 27 Jul 2026 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.25
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165792; cv=fail; b=NJWMmmACQlgkBIzzEHOA+0rjo/osdIxSavdU6k/vaz4GBT0zTjRPI8sNZ91y0GF9zn4g+qoorMhDkDah3ntJPhmxRLjJuu8sLWk+yWKjX/z57ESmOW4WuzVktaTt/YBFWu+3TSE1I2jjIVtnpa9mcLCwFv70UagYjiYOmUHeNek=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165792; c=relaxed/simple;
	bh=E9jwopkqP2quRXu2sZN7oyuYreVvtjyJG/ZXPur23eo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LOKyVcEb+G23c3L9CdouFnqLIAu1n3dn33EIol8jFHtgnpK967QRstf6ng1yNuDelrCNr0soL1OfzIxO01V6CbR82PD35q3x0V5aEeavFgJemk0JxO4AIj2hdEw2icTQwptJy3FKpx8YBvqSwF5RGnBGaDKzZG7TI/CsPgX2Tms=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DlYXL9yF; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DlYXL9yF; arc=fail smtp.client-ip=52.101.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DlYXL9yF";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DlYXL9yF"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ko03y/m5/74iBp5a+I2/VCVEy0/1rj9vPYXACXQ5q+DXSFqiUWFsmJwR6QYHl7t+eB9HJ0k52YjsXeG+enEbL+DnPwKVt/wQacu25qF87gDV2vzOlXjNmqVi8RDAhpoy5M/ETpYOxIuHjmPQwuDNqnQ3AkSzZ88FZtlEW0P1fWBc9FAgWklpIjR5DdV8DrbKlpx2isOpbq+DZPW5BY+lmlZBL3LYbksrhK2fFaxlASgAdpxA00bceZY6SVqxPQ/MvthROVK8f5v15ZQ/A0jFuPLU/yN0I04dsxa66sGkYuO4LkVCRYJCHZBTe4/HmM6AMMOzwxx2pyFE7J+9tMESZA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy6RGZ6zCQTM+RcrUl4aI71rhrShpRfAg4Nrp62RUr8=;
 b=o++VJy5dNdlV0ldM2o1iR43HYo2UNV7m8wK5CPwz+dZ8iRIkf/nCi097T1jyid1cyHpt7rwuxSOrUVkrWCTmph3Nn2GwAZ4bn/DvVguzLlcTazQLf2o6xxztBV7i9lqKU54jvyiyU6X5ReliFIdVndK+DQQsuHWpkaiKRmG/5xupjGm1Lc2YOWihtX7u2x0D0bkaJa0XDtb/g7h4Cda3C9jRWflWSIrFOFsCsUoDZkMlaEQ0hOhDe2a622dxbMRYzXj53T1KwboOYXfr3lSrmsRe4t1awUYHOfgz8W9FKt6U0/Y4D/25PlJU8bX0Z/g4oO2TL9mhG9JDVq6LKjwX9A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy6RGZ6zCQTM+RcrUl4aI71rhrShpRfAg4Nrp62RUr8=;
 b=DlYXL9yFgf6DRHJGfkIapuzU/Hg0cov7LMXW5Glt0ZPj9xEBNdR0hYL24oMOSY+C/zK3mdwRYqKOLIx8SBrlzOMDG+1vtmIZiDYUEoaJWuIujL90ukebovPWyXTnvY93LDN8drPVnpllJ8UKLmJgys/eKzSuIugtr9qpJnczJVk=
Received: from AS4P192CA0039.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::20)
 by GVXPR08MB7848.eurprd08.prod.outlook.com (2603:10a6:150:16::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 15:22:57 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:658:cafe::85) by AS4P192CA0039.outlook.office365.com
 (2603:10a6:20b:658::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 15:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Mon, 27 Jul 2026 15:22:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+tNhShYBfSASjsOHlGaKYNfZQxCeLTFBEO1mytfldgfCeZHxyFv1a4Qk2RYa7Pj/eMDMiJWAiudOWhb671dDnJoA3biv4S4v5CFyeYAE3MerlZwA1a04i9qVr+rnzILZ0O7rUpb9NP3H5G3dTp8nCxPCQkAK8UK+r4vka35maO6VAQ02Cvn8z2N9eBfvgRG1yUUX/FvdpY26N6K+Cj7vwR516do9WUUEAPMnKfctNrTV5u83oundy0rEIuG2xRlnGKaoPU0oqNgfnQ1VL2r8TmdNdCDJUQ5p4t8+NaDpqC+jL4Hy0AewU32RuFZaReO+yxYgg9GCcVSbgJAmBl2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy6RGZ6zCQTM+RcrUl4aI71rhrShpRfAg4Nrp62RUr8=;
 b=eOxYSjz6lIqGc2/9550mwez5TMIoynawggqV2egaGa914ORc+myuq6nbk/GEnsYFHA5T5Qj/RPtaq2W2wbrX0m6oGCCnIYrDZTRBGGRgPVA+tgoMYDRqg/HPSdYM8JWkR6eqND2BsrIxfUoGYlL/ssobPXdyZrqmWor1TootNLY/J8MmftX19A7olXN6PhZJXfZ6EWamH/wdrYCbIZfxWvt8pUWRDcINOMMIjyfF3cyxGWaP2af2/hMYMoo3jjB4PAb6mbDew/rvbqPk6Twm2/nKVmedUxtX1WshEGPvu3SnoHPEaCRQolhGV+U8zXkgVLmgQAtAkp+YpwfsLaCloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy6RGZ6zCQTM+RcrUl4aI71rhrShpRfAg4Nrp62RUr8=;
 b=DlYXL9yFgf6DRHJGfkIapuzU/Hg0cov7LMXW5Glt0ZPj9xEBNdR0hYL24oMOSY+C/zK3mdwRYqKOLIx8SBrlzOMDG+1vtmIZiDYUEoaJWuIujL90ukebovPWyXTnvY93LDN8drPVnpllJ8UKLmJgys/eKzSuIugtr9qpJnczJVk=
Received: from DB9PR08MB8651.eurprd08.prod.outlook.com (2603:10a6:10:3d1::9)
 by VI0PR08MB10798.eurprd08.prod.outlook.com (2603:10a6:800:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 15:21:53 +0000
Received: from DB9PR08MB8651.eurprd08.prod.outlook.com
 ([fe80::8fb8:7cf9:49c4:6f90]) by DB9PR08MB8651.eurprd08.prod.outlook.com
 ([fe80::8fb8:7cf9:49c4:6f90%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 15:21:53 +0000
From: Fayssal Benmlih <Fayssal.Benmlih@arm.com>
To: Cristian Marussi <Cristian.Marussi@arm.com>
CC: "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"d-gole@ti.com" <d-gole@ti.com>, "david@kernel.org" <david@kernel.org>, Elif
 Topuz <Elif.Topuz@arm.com>, "etienne.carriere@st.com"
	<etienne.carriere@st.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "kernel-team@meta.com"
	<kernel-team@meta.com>, "leitao@kernel.org" <leitao@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Lukasz Luba <Lukasz.Luba@arm.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>, "peng.fan@oss.nxp.com"
	<peng.fan@oss.nxp.com>, Philip Radford <Philip.Radford@arm.com>,
	"puranjay@kernel.org" <puranjay@kernel.org>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	"subrahmanya.lingappa@oss.qualcomm.com"
	<subrahmanya.lingappa@oss.qualcomm.com>, "sudeep.holla@kernel.org"
	<sudeep.holla@kernel.org>, "usama.arif@linux.dev" <usama.arif@linux.dev>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 21/22] [RFC] Documentation: Add SCMI System Telemetry
 documentation
Thread-Topic: [PATCH v6 21/22] [RFC] Documentation: Add SCMI System Telemetry
 documentation
Thread-Index: AQHdHduQfkLrIIQFSE+bqj4tKF4ehg==
Date: Mon, 27 Jul 2026 15:21:53 +0000
Message-ID:
 <DB9PR08MB86512159FADEE5E25FF615D3FFCC2@DB9PR08MB8651.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DB9PR08MB8651:EE_|VI0PR08MB10798:EE_|AM1PEPF000252DA:EE_|GVXPR08MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 234f16b0-e67f-4760-d92d-08deebf2eff5
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|38070700021|6133799003|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 FDAgr6utpuUjLRTxyPcoaMrfi6FF5PJst8nSwK1bjGUVgC8Yw0NM5enkHWJzldjQxDZZQ6VVnjErKeOoKd1861IuKcRQ3x0O+m2o4H+dvU39mq162GLAsVCvl9Lie1nLG5ajd1AIpsswYUqYgSESp0kHpRzFLgSeStmSUHqHvwKhcuP+2KkGup8LOlimXWr6KbsI/sh5xVo0j4g5BAmGFq+PorHva+1A90j6vreFa45rFPKyobxM3dI0tXwOBe8GCWHy0EDsecJd4RzsB5dBHyOOdRvqCmPbYvUMptu4jgckQ4BF7KxqOTOYr11v1mk49rjBPQ8+rA2Ykad4GWsMhXUMhGU6jiM4xMMsW9VqL5SYSGjQkjigXEBq/WUV7Ii6zS/oWnEb5mHUd22w1+x5RDZtfwmuzaV67Zx3n4rhgpaBi/ZvhophXCz1U4GR2ZBrQ0BNZRA3WFbTIQDAybuv7Raw8+Z+2R/uxpWkUiX5kh8yf3UgWAhgZWE2OeUDseJSz2VUVhFsFUifqTgNfvVwdTN19RMMru05csDAuuFL8yaZG2RI95wWAtIpOnmeT+rOaKQEQ8KYJrhR+rhIAbMBFd+WJJnmlxOKTNOCzLONBSacuXSMAChYcjNFnsAWp+llMJ9bVCGqBD5TaZBqnb2UywI4cwd/z2odjc7kiYZHwvVstzmEGFFpJTSv8TuwcZlARhB9vDhpKesCL4w27bbR8gXPD6e3C1e4tsqrtKzGh2w=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB8651.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(38070700021)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 BuiVuG7zPY9VVM3tjcblP/GdNtjPdBBbJ447qP/Vo+3XhCZdUlVCAAlLRDiMd5DxrFglPnthpccvRwCXH0tbLecJCtXuNOymrdnyWIf6QOdYHCZ/x+4zfguWuDOYQzDu5KLlOs6Vd4wzNcN5bJJkwfGlYbem7bo6Ja1Gll5JBAi4xURrVelNZpJOR3ylXzXanAIdBNcBY1aNx4/vdiFdFakF3kUmxZ2R3O0LeTFL2Atn2D/0DrE5NL7/KDchyyGBOCofoJsN05+GE9EPx8MhHCTcnflewt4KFZvthrqVhegRIjWPhYd/X7vMNvKjoXYxyhjyyo6Do5xrTqhEo1BHAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10798
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1ef72509-b17a-4219-bb90-08deebf2ca17
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|14060799003|23010399003|35042699022|6133799003|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	P6zlQPb4R9GVlozRI76H9WW2xBeNe0dXb/2a72llxmhG3dayA/rC2IWrHVHvvoheMptmWJCmC+HA5SjX4boYlPjjA2O8BhEvKFAn+dS9fg6E9aeSKk5+zi8LsAAjbiwrpXslS3HuxFQEGtxYqE0xnvwFgW1yQeqj8es541916KPM/crNcjPRoKQghviHWkYiJ3a0rJbF2M6K5bbiOecr8WBQ1HV0fJ80r3ZORsD03K3bBhYd8I06hYqO9UuDsh7sUTMz+LDalO6gdbiRH0tZ0hbvb/XlCQe6VnMMKGhmhvw0t3TssKJicD2SAmQi4CphrHiqKmx0WsROW7VBSVLLmGncjgZq+8QcB2jL7HAQc/XyolsosMJpGQnK+Msan/7REns11HLErPtOMQJmO4ZfJ5DgXeQ8xyunI3U5ugXxddjPfNe65p7akCh8iweRCwrNo729AFFM43k8Z1SD9CwLwHrrY/iOJ2BAJTbwhEkUmSB0hjTkHWTvCIJLYGyUUXLyEL3DS/X0+sQIPDE+Lyx6nz/dA2znT4I0K9DdgftXtw1WihBw2XXMUUgGWwY5yEEJqEnH9pO/la7JELxCal8vYRnvcaYp4ENhR+rskwUfw8kP2xIoN3WoBy+5IKhXjI4yDnEyZbeSI+8/SXnLiRnaznkiyCWVBNo2QI27OP9rceLtlqoDGZOvZNjNtL8lKST6s9rFWxxw7l7xkFGwFhuZ3w==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(14060799003)(23010399003)(35042699022)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YyQY8AIlF8TO6r19Wi7X7OKxtbbun0K0UEpy+JGrGAlY9y9rHcssAvBNtobcIapCMmteUJXw84x/QbduTHyNbMS9b8AuS6MaBbQU6RBIoAJ9vfhAwgEM5CtUlCbR8ossKuPKbu+4pIM2AeRB4YTaYcjbGOXXWJFXthrZKx8AlHrvi92V+cso7ED/h3PGd6ck8liIFhAyfo+zy7AsGofyu4JXfG2RpSc6QF0W8SRkzd7BbYjWHcvzre1Pk76fmO5FPZJIQJSWRktaCrWSWyC7SsvZ9ULrk7KwdpeqO9zKkvmRKnU5tFc2nooLEdUuuvE9HKA6SIPzqCcQPaI32sBU47e0MLil8hN3MrMRGHEjo/HV0Xf5BsROEY4DFK73C1EHCsn1QYKFf43eBuFfRhPiG2di6RUS7NK+MbGwUJQRI1+iWU+PHdba0T8Mk1Zz+w+i
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 15:22:57.2736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 234f16b0-e67f-4760-d92d-08deebf2eff5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7848

Hi Cristian,=0A=
=0A=
Some documentation comments inline.=0A=
=0A=
> + - SCMI_TLM_GET_INFO: Gather basic Telemetry features like number of=0A=
> +   resources and versioning information.=0A=
=0A=
This was renamed to SCMI_TLM_GET_ABI_INFO.=0A=
=0A=
Please also explain the distinction between abi_features and instance=0A=
features, including that reset requires both ABI support and firmware=0A=
support.=0A=
=0A=
> + - SCMI_TLM_GET_ALL_CFG / SCMI_TLM_SET_ALL_CFG: Get or set the cumulativ=
e=0A=
> +   configuration of ALL the DataEvents defined on the platform.=0A=
=0A=
This needs to document that configuration is global to the SCMI instance,=
=0A=
not per-open-file state.=0A=
=0A=
Please specify:=0A=
=0A=
- whether concurrent callers are supported;=0A=
- what "last writer wins" means when multi-command operations interleave;=
=0A=
- whether SET_ALL_CFG can leave partial state;=0A=
- how userspace detects a concurrent configuration change;=0A=
- which operations require write access or privilege.=0A=
=0A=
> + - SCMI_TLM_BATCH_READ: Report the last samples for the DataEvents IDs=
=0A=
> +   specified within the samples input params.=0A=
=0A=
Please document failure semantics. Currently one bad DE fails the entire=0A=
ioctl, preceding successful samples are not returned, and there is no=0A=
per-entry status.=0A=
=0A=
The documentation should also define count limits and the input/output=0A=
meaning of num_samples.=0A=
=0A=
> + - SCMI_TLM_GET_SHMTI_LIST: Gather a list of open file descriptors, one =
for=0A=
> +   each SHMTI memory areas defined for this instance, that can be used t=
o=0A=
> +   memory-map such areas in the calling process address space [...]=0A=
=0A=
The mmap contract needs substantially more detail before becoming UAPI:=0A=
=0A=
- the exact mapping length, including offset and page rounding;=0A=
- permitted mmap offset and protection flags;=0A=
- that the returned fd is read-only and close-on-exec;=0A=
- cacheability and coherency expectations;=0A=
- the valid lifetime of the fd and VMA across device removal/reset;=0A=
- whether mappings become stale after reconfiguration;=0A=
- cleanup using munmap() and close();=0A=
- the page-alignment/security requirements for bytes surrounding an=0A=
  unaligned SHMTI.=0A=
=0A=
> +		/* Enable Telemetry as a whole, set a 400ms update interval */=0A=
> +		cfg.enable =3D 1;=0A=
> +		cfg.active.secs =3D 400;=0A=
> +		cfg.active.exp =3D -3;=0A=
=0A=
Please document the permitted secs/exp ranges and how an interval is=0A=
matched against the advertised discrete or segmented interval list.=0A=
=0A=
The timestamp example also needs the timestamp domain, clock-rate=0A=
conversion, wrap behavior, and whether/how it can be correlated with a=0A=
Linux clock.=0A=
=0A=
> +		return 0;=0A=
> +	}=0A=
=0A=
The example should close fd on all exit paths. It would also be useful to=
=0A=
show enumeration allocation/error handling and SHMTI mmap cleanup rather=0A=
than only the successful configuration path.=0A=
=0A=
Thanks,=0A=
Fay=E7al=
