Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34597373BE0;
	Mon, 27 Jul 2026 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165848; cv=fail; b=fC4yZupURFbBdKdPV8OQvd2n3Uo4qOvOuYHFVS8yNfqTkXSyML4lY+vQ8u93vlvzJaBCP0GM7bBzC+T/K99J8Nir65AJB1C6rxlB47rifxwQFwCLZx6/jI6qMGcj044BrqOcVczN66LQvBChZzNCqVxM4xkj79ZVrf3/DFJGYEg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165848; c=relaxed/simple;
	bh=+iZtQnSKjhcVHhy0Fx3rT8JPeGuiXeVLX/l3aUO5jBY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bPlMQix1++eH4uU0ymJLOoZYnAwtQn4/ANM30kCbAgmC9fVxJx5sfmFORkG0d4Sq5C30vxuM54DBaPBMdMOaAcGCFTHNvv5PRxevdxlreHv4cfRPRA4iT5JmMv7olIwvpysKGb2lAUhckUPqcqCQG2c0/6lwv+Mw3JGW2f1V538=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bxxLJd70; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bxxLJd70; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bxxLJd70";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bxxLJd70"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lsOXUcTkMH0wgnRfjtlFHnfK4kGbTozHnBw9mnXOsrfLskuaoV8WDN3UUNhVgvJ5t4JZHfXAX7G/wqMjduf5DHPELN+87hXfSfIP5+/Jzr+pKLj8Ier58vB8xJsa6FWjOLU8XMz8vF7n5fjV5tQ6aF9DU5IcOFdxc1a2dhxI6ggwjR3JAm9UxxaoK6SDCEidY1vy5pMRGFMy/WNCzFEJzxGOJ94lmxJ9HsqqZHWyStmFRT7c3FtqIlHnsQhnZ3FjyeqUg8CgMRmhxsOGZLLk+YS2E1T5SQnP/6GMZBtLknxpoEdX8O5heBKxXYP+Iob5caPHCcQ4AkIjDQCbcoy9zA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHXSr3kLDf+drcvK+aU4E9YxML0lP18lxLugO3/JzIQ=;
 b=uP8J9Jp/SkgLxrM4bPlr82Z+b/PO62gsTZs7TMWh+IX4JzmB+5xOdRBNqvAKmwzMnKgKGDkAZHSUyxPUqUURo+HhxkBC820IlXInp16ejtO+is9tKLVl9uMoW09/850qdozCrywrDoD1WnEG49iOBvo3XFbvDPlRI3mlKMSvYzoE/xzg+h2kJeEQtuU4NrOkWB+OaEELgdFPI9O/B/+bzzQ6McidsknS9Ngbp/SIMjwrc5iLjlmCgh3E07qpbm5LP5ZF1frQJQjwJwJisiEZVaezE3hCN0Y2sNaKGUuX8kCHIELGu0mhoeeE9/EZyRy8hRnbMj1/qjOmzUXf25u4QQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHXSr3kLDf+drcvK+aU4E9YxML0lP18lxLugO3/JzIQ=;
 b=bxxLJd70ak7BIJaeZ8XMPB7TXr0AziwVsn3zXam96y3JWqIByUr8sryaCgzM5EDBZr4YJ/pLRTl2yXtTVp4hy0y/IEqGRAZaZsEx5S4CQHB4JmUy9xWTTHtO058DiIiMy6f9K/3dhsQk2NRxVzga44cFoXtHcJIT6WVlFbAaycY=
Received: from AS4P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::9)
 by DBBPR08MB6155.eurprd08.prod.outlook.com (2603:10a6:10:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 15:24:01 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:5de:cafe::7b) by AS4P190CA0006.outlook.office365.com
 (2603:10a6:20b:5de::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 15:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Mon, 27 Jul 2026 15:24:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vp7i+iI99h9aGBywoZqmE7NfXvcpu92Nc+tig1GdjmWArIVn+b4CY/pDp3kSjgDBZerNG006EmUjqn8F0UytTRRF4gu32Qub3UW5W+MWo3O9lBOR8RS5m079eytOQLQp03jlxyCvSATd4QwjCedSyYmG0pfiW8h1JfPm8fm4B7RGMrxOLGk7upe9487YTN45gefJwwtB7J27N062HAGYvDTaB+jtPWCKPvCM4tawuTJ425zj0OdSVhqvg6ViekrEt4mgO6nfanUspVJs8KLwo+66Wo6S48KGUJGDJV8uv3c1fsm2VbVK1P/vgSWTsIyVj7RHPLKVlYdO4amBybY2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHXSr3kLDf+drcvK+aU4E9YxML0lP18lxLugO3/JzIQ=;
 b=lhMtTGFnMUAOZmlEgS0ScdqmWROam1/YvTlP3EFZNVCHZGxlHFH3X0wTUdPW4iYXmgy4oMnLgDRTyFepmTgc9tiHM/NSYbdVozSSvVcE4qHvMKyjoWnO6SVV8UmM+++ChTb7U/CkMMQHf2xf43lAHe7id8noC8TxW8S+6Y8nHv8PhuoWyd/E/JTG/y6RNHPqlWDAx0uzs1tyQqwZXlu41pzWt5nBgsGv8jLuSjW4bstgkID/c4NSx9ZFZm5ZfR7HXFy1+JE/SXnurbDVzdHzhcajMHnsu/DOzLUlQ+npKl7KkohtCaO6NczuBBsgNnLC9kAxdDUh64nyXPh1kQOayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHXSr3kLDf+drcvK+aU4E9YxML0lP18lxLugO3/JzIQ=;
 b=bxxLJd70ak7BIJaeZ8XMPB7TXr0AziwVsn3zXam96y3JWqIByUr8sryaCgzM5EDBZr4YJ/pLRTl2yXtTVp4hy0y/IEqGRAZaZsEx5S4CQHB4JmUy9xWTTHtO058DiIiMy6f9K/3dhsQk2NRxVzga44cFoXtHcJIT6WVlFbAaycY=
Received: from DB9PR08MB8651.eurprd08.prod.outlook.com (2603:10a6:10:3d1::9)
 by VI0PR08MB10798.eurprd08.prod.outlook.com (2603:10a6:800:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 15:22:57 +0000
Received: from DB9PR08MB8651.eurprd08.prod.outlook.com
 ([fe80::8fb8:7cf9:49c4:6f90]) by DB9PR08MB8651.eurprd08.prod.outlook.com
 ([fe80::8fb8:7cf9:49c4:6f90%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 15:22:57 +0000
From: Fayssal Benmlih <Fayssal.Benmlih@arm.com>
To: Cristian Marussi <Cristian.Marussi@arm.com>
CC: "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "d-gole@ti.com" <d-gole@ti.com>,
	"david@kernel.org" <david@kernel.org>, Elif Topuz <Elif.Topuz@arm.com>,
	"etienne.carriere@st.com" <etienne.carriere@st.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "james.quinlan@broadcom.com"
	<james.quinlan@broadcom.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "kernel-team@meta.com"
	<kernel-team@meta.com>, "leitao@kernel.org" <leitao@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Lukasz Luba <Lukasz.Luba@arm.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>, "peng.fan@oss.nxp.com"
	<peng.fan@oss.nxp.com>, Philip Radford <Philip.Radford@arm.com>,
	"puranjay@kernel.org" <puranjay@kernel.org>, Souvik Chakravarty
	<Souvik.Chakravarty@arm.com>, "subrahmanya.lingappa@oss.qualcomm.com"
	<subrahmanya.lingappa@oss.qualcomm.com>, "sudeep.holla@kernel.org"
	<sudeep.holla@kernel.org>, "usama.arif@linux.dev" <usama.arif@linux.dev>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 22/22] [RFC] tools/scmi: Add SCMI Telemetry testing
 tool
Thread-Topic: [PATCH v6 22/22] [RFC] tools/scmi: Add SCMI Telemetry testing
 tool
Thread-Index: AQHdHdupzyKnCmfBNUGjj1qpYOemlA==
Date: Mon, 27 Jul 2026 15:22:57 +0000
Message-ID:
 <DB9PR08MB865101182545D5B09EA6BF72FFCC2@DB9PR08MB8651.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DB9PR08MB8651:EE_|VI0PR08MB10798:EE_|AM3PEPF0000A796:EE_|DBBPR08MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: d3564c8c-2191-44b6-b545-08deebf315e2
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|38070700021|6133799003|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 78fOWYiCrHXrIjT4uwKn6CQ1y45AKiHqNqVefF4iHu3nb656rsS1hBDZG7QQo4CPf2x/OjcYWfy/A15tFCKnX0yMfjPsifrdTAKli8gOhsxMO8QCVwCgL884c71DkWSz0apoNhhlDdsOYZYcaC/PNEY71nh3vTUDhFsNvN7HrKl8THkdueqItwFltaYZisHmLDgPnc+tkBCO/fB9dR/IwLa12OV/P/3hbzj3qH5NzwpCXK8O1/bSAaZ7pY4g+iHwp5RiXxwS4lEWnfqH/ABp+hGhuQ5E5y86echhreoO/IZr4HV+oCb2zWGXILzqYB6gf4gYgFDYPljxOjKF0Yjy35a6zOrruokwtdKbkeupZo2PgyXrUbg2P4Dwiuhz0P0aw37XNtWLaqR7cejPoeMdmQIoFTKUIBHeMHW+lSZ5prgt4D6jSZLMJrlutIGJidZfo7YbOfSbyiFooRqMuBJ262rzncwhgRNFfrSWl7PWyL1P//4AUJPam+20w0GPogXCuzDiZhAwJ0Y8WKh4rTooTBfAz0kNeLXOqPNhSiiwLfsEoaPKzqrQWPRXSF1HxHSennXtrNW2+eg4QOJn6NsvBJ+Ba5JrfROoPcrVK3tup35e4qOc59bXLu+94E2f0DR4ijqd8Felilwg6o4faIJ+POZa14r+/Ba5U+qn6DUdDgLxL16Hiy0dvtgX7tUoa0yYnsJpYK7ImuaQmbmEZFbWqfLaSpzS4kH5lZPFeeDUZfA=
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
 gD2jfUn9lkjo4mZAUfWQkfuRtVnS1dzobP8ncIcU3lVp6xZmZ/+oqdZh5BijynmFJ2lMhZAv9GhypSzlzwTlftgzQW5SqYKmykHmWbpb+8bR7OpVKjsK41KCtsurdxI9RUFI7mJztYqjjuYZ9kdmfMl7tGEppvVfQ1ObcfMMpBnvpjPNqKvmwUkbC9nCHUxK2+wQuQhqTobsW+FnfBEZ5NIeYT6jDJ34WfZgJegyanOUAjLQW6QiJh+RVSUibVtFVmnSnlnmQyPvJ9Epq4pHv59AasTEyYbMXDstSsQT0wn4hvmeTrhyMKPLEY68VfuRRhhMv8LH1loabi6jAXypMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10798
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6609a89b-2ea2-49ae-8a44-08deebf2f027
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|14060799003|376014|7416014|1800799024|35042699022|6133799003|10067099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	RjtHfAWP/cpho921nIChX7DA+VdqTX5LitR/JgrxmDb9+hZWVKA5lbLFz2T+2YEm3s9y3CjiBqOsqGfFeb0KN857dXtMxU+kDmye5VAm7XMhHcEiXv9AHDz0tLbSZmQRalHpbSDu2ywjYoOdWX602KKUNEe4odUVZ2abgbldhX0SYRW0jfvoBMA7WfaOwkAMyBihtbY6YJEVVZuV8Riabbt/XCX5zSo6yuAcvNf8bg4bXLVZ/4ascCOx34/8aYwQWa5y0/VHNSnhVIFBxvpoESV1X8rOVpqfJljJVb/dM8BAkAGmYPTzeWCa7pg0cc4EsolPSJvWSHcahqZ6q1EBXJ2yahR6y3MeLGfrI4D4bfmF6E2uyuo2vWDVa7KhsdUmj46L+RqP6cqctcdInuqbI3ey1DvKfxdEkCEF8uvMnZNrqa8v/TEozn9csjPDNWa7ctZ1hcZrrdIrWKlDczg0zgeNzlgvLmrI4Nscdq+iPzCVYo3oRBYx2ufaQHOPAl3uXDh//tASGgFkaZTSqekQuGj44jo2DEWwnoH9FYDutvYnIY7e+DJgt3PolXECIGPvh8pdA05XjGIa2InWEFG0FGAMcw1OIqoFe+CuUUZ9BhmCP4GGbIdojl1VT58BRmKVgYYwjpE76WfAZzg1vJCGxir65nOeUzoBKWJQ9nUSb1cgPrmkST2u7kkoLl8YmicXPKQHAR7guLCXZorcZP1YxA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(14060799003)(376014)(7416014)(1800799024)(35042699022)(6133799003)(10067099003)(18002099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6U0/mnXa211a7c0QbqPZRX3AU7JrVyLubxE8BKKqhXSCOnJaz3wq7RuK5+/fYAVxL5x3teXlVjZv6TSG+ZwCJr5TDxH2IMMZ9uyYYm7/y3nGT6ae3QjVtqO5OSBddTftid589TUMT9crd9CkGwxcRYRqgzuWpHOVO7s7CLSYfoPsvLE3lIMzk/O9fW9HYAPdPpN3lB7h/Inbnlu1tGLXZoBeibs7OamK2Qgswo0vYKKDKnsjE4sZtCfr5l+8yPCxS0ZXfQndR0FtvKIRr2CsYmVJAwF8eGxfQEvlDrmv0xlWq8NutZzwX6nNXJIoGFNtxffIyzUI5LdZhVybgXGCbafgtQXPsc2cYv0xsDkmG0tJdm1KWdLxTxoPH630DXgy4KWiwsfdDv2+pvgxMWpRZjL3x1oOY83+ZK2P+lB0ixfBB7fQT+SS0uPFVuMZTO0Y
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 15:24:00.8995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3564c8c-2191-44b6-b545-08deebf315e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6155

Hi Cristian,=0A=
=0A=
A few issues in the test tool inline.=0A=
=0A=
> +	st =3D malloc(sizeof(*st));=0A=
> +	if (!st)=0A=
> +		return NULL;=0A=
> +=0A=
> +	st->fd =3D open(path, O_RDWR);=0A=
=0A=
st is not initialized. Several members are only assigned when the platform=
=0A=
reports nonzero resources, but later code assumes the pointers are either=
=0A=
valid or NULL.=0A=
=0A=
Please use calloc() or explicitly zero the structure.=0A=
=0A=
> +	fprintf(stdout, "\n+ Found #%u SHMTI areas\n",=0A=
> +		st->ssl->num_shmtis);=0A=
> +	shinfo =3D (struct scmi_tlm_shmti_info *)st->ssl->shmtis;=0A=
=0A=
st->ssl is only initialized when num_shmtis is nonzero. A valid platform=0A=
with no SHMTIs can therefore dereference an uninitialized pointer here.=0A=
=0A=
The same type of guard is needed for optional group interval information=0A=
when per-group configuration is unsupported.=0A=
=0A=
> +		grp->ivs =3D enumerate_intervals(st->fd,=0A=
> +					       grp->info->num_intervals,=0A=
> +					       &grp->info->grp_id);=0A=
=0A=
This calls the group interval ioctl even when num_intervals is zero.=0A=
Apart from malloc(0) being implementation-dependent, the kernel currently=
=0A=
has no valid group interval table when per-group configuration is=0A=
unsupported. Please skip this operation unless the feature and count=0A=
indicate that it is supported.=0A=
=0A=
> +	tdcf =3D mmap(NULL, shmti->len, PROT_READ, MAP_SHARED, shmti->fd, 0);=
=0A=
> [...]=0A=
> +	tdcf +=3D shmti->offset;=0A=
> +	do {=0A=
> +		bytes +=3D write(1, tdcf + bytes, shmti->len - bytes);=0A=
=0A=
The mapping length does not include shmti->offset, but the code accesses=0A=
offset + len bytes. If that crosses an additional page, this reads beyond=
=0A=
the VMA.=0A=
=0A=
Please calculate the page-rounded mapping size from offset + len,=0A=
preserve the original mapping base, and munmap() that complete range=0A=
before returning.=0A=
=0A=
The write result should also be stored separately. Adding -1 to a=0A=
previously positive byte count does not necessarily make bytes negative,=0A=
so the current error check can miss failures.=0A=
=0A=
> +		tdcf =3D mmap(NULL, shmtis[i].len, PROT_READ, MAP_SHARED,=0A=
> +			    shmtis[i].fd, 0);=0A=
> [...]=0A=
> +		start =3D tdcf + shmtis[i].offset;=0A=
> +		end =3D tdcf + shmtis[i].offset + shmtis[i].len;=0A=
=0A=
The same mapping-length issue exists here, and none of these mappings are=
=0A=
unmapped.=0A=
=0A=
> +	if (ret) {=0A=
> +		free(st);=0A=
> +		return ret;=0A=
> +	}=0A=
=0A=
This only frees the top-level state. The main device fd, returned SHMTI=0A=
fds, arrays, group descriptors, intervals, and mappings are not released.=
=0A=
=0A=
Even as an RFC test tool, a single cleanup function would make error-path=
=0A=
testing reliable and would demonstrate the expected UAPI lifetime=0A=
semantics.=0A=
=0A=
Thanks,=0A=
Fay=E7al=
