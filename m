Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA11370AE6;
	Mon, 27 Jul 2026 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165713; cv=fail; b=Kco1TVlOfPxXGvPl8J5NsfJatASZ9zMJfP/klku1fXk1EVjAm05ErnStHMNFWjVWr8kZAETLTNBDcyefYjA5GKrjFZFXDRMfbY3ME2QvFcQX4WaliP7BktwkvbazjXIOYCvTvgBfe31qgJXQur8IevXi1W2w71lGlmnQkl7i75g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165713; c=relaxed/simple;
	bh=yH2V4VIizrdlhs3WIf+ZI92/jAFquiII0w9SKJV4kM4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oqx9qfC267BardSSaQP+8pYiG2zcaNNhPHttpqs1Y7diMGq85g1WR60yIEGsovKqlP4QLSZtrmOh77tOmtxVeXMUH2ehP8kHXAEaDAax2H/VG5pTke8CVVeJ1Y30cO79SD9aRWRJ/SUJldJVpuiHTGPOCnw0J1QvCj7Jpv7r+hM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ewMH+3mB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ewMH+3mB; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ewMH+3mB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ewMH+3mB"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hB8bEKnH+gnN0NYOpdEJHTMgph3/Z6LifADZvQlIlNiaDDcGbulLE9D+xAKhP9K31/sXm+TrYOhm/yQ/uMZDSdQZ36j2IHFhlD5qp8ev8CBREcWuoaYMMGu+LfN/SsCIkOV49nDPNsj/civhanNOk5/q9m2FP/3HGw/IkyBNZOlnj3hrWCf59nEi0SjwC3eqr8OqBV/xd3mLmfec1RRPkyiVF7zLiCqOaGwZioDc9N8HmIc+aHNabpQmEVctRI/3dJg06Wdd7uxVSjznDlWkWHJ7WRuk/J+cnYnK6ReUOdZjkLwJ7zKBcCxBAnrfgeO641Y98cM9otxcoK3scPLPIg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC0wUwMR0+EiJEYIYVwg1/RvZiztQ3cjIB2//NjQ/t0=;
 b=Vu6bjOmIuP1CHHYUAWPshZ0+hbnSNY8X0TrYtTocOb3bTtzxC8/kMK5OdumirxKvmGvRY8H7xbQh7XrwBxzFAlEKIt69LQyX64+NzVOzo1ercrV677Udxh8zQbnTBKGqYcyheoJKQb3gCKcc2tb1Un1KN2lMzvHxST8fYS5z2GgoWyHfS6Ml6BL+lw1xlJ5Ov1fH1dsghWR5t1S8jBVP9TJA6Rm+RCD33X5cD7bpS+urYLeiyZFKthXxQoJFUIuiNgX5aovMSXfyTB/9Mnvei7lAhKp9i15+LCyvZhcs1qd78M9c8ekA5hJ+5oQ0LVl6iM1jK2xZjToS5Fcef35QSQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC0wUwMR0+EiJEYIYVwg1/RvZiztQ3cjIB2//NjQ/t0=;
 b=ewMH+3mBVpQzRfNcrGn+fFqeR9fmmo66WsMDlO1jIBSL5C3XGJuryvS7vb9+51Imxr2GdPo3i6gbguSb8bW2776z8MRUh+tp0mTphwmkNTbZyk4Of8Gt+TcHDcMqUC9sSIYgBBu+nPWz9CA+3MT/kLEr4QIWmkyZTLHXocRhrNI=
Received: from AS4P190CA0048.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::21)
 by PA4PR08MB6048.eurprd08.prod.outlook.com (2603:10a6:102:e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Mon, 27 Jul
 2026 15:21:41 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::57) by AS4P190CA0048.outlook.office365.com
 (2603:10a6:20b:656::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 15:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Mon, 27 Jul 2026 15:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hq5hY3wX03M4x6MD/QTD+a94UXEvFztSDUbPjdRUam9EY2suuQqw8EjPIh3DP+VGHxutctM3UMI12TKjzn8Jy4lX4XTJDOtNThk5cBacTC0xf1XyMvJRE0rFzBk/rodrvN2Jh+YFKxaS5nA2pzxlKxecCfBr9P6ONdAJt4b+QPkJZPNLG6RglT025iyE4ELN0XaqnkZZ3LtqbssyNT/xEU+27MOe8+W/Uo/ps/deG3fvcRPGR6NRV2HBkLHYjRHCOmq8agXq+Bq6vokljfZeA1MIrwcMkz9b1qzhNTwGdqSBdX0B+HnVekt+4I2R9LHYX/18W0cv0GjIcsKpA+tA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC0wUwMR0+EiJEYIYVwg1/RvZiztQ3cjIB2//NjQ/t0=;
 b=Jp3r4hYSAaYbsBE1UEFHiFGq/KW+OMqm7tLT310hhC3W0pH+G5FFzo7Va4DX7sQOHwc2UaANiFy54G5jVQP6kRqDXVtgpuu7D7V6INLDwa+XtVh3YRxdMVH2WE13SogvLQkcQnSz+7kaC8TAgs62WcBpryRELfS1S7L5KEei7YlvPuRhL+LXqAdo75f8jqtud/63qT75TnksP/Xfo4Bxioz/Fe5kAAK9SdtoC68ARPe2lVaBuu/wDQxJo43e5UBCq3z7yxBJKihjwb3B+ZF+6hV9shkcoILqMLecuc6LqIYQfajFzGDVFOl7g/111bgswovO5LOWhWRBizGXAhfhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC0wUwMR0+EiJEYIYVwg1/RvZiztQ3cjIB2//NjQ/t0=;
 b=ewMH+3mBVpQzRfNcrGn+fFqeR9fmmo66WsMDlO1jIBSL5C3XGJuryvS7vb9+51Imxr2GdPo3i6gbguSb8bW2776z8MRUh+tp0mTphwmkNTbZyk4Of8Gt+TcHDcMqUC9sSIYgBBu+nPWz9CA+3MT/kLEr4QIWmkyZTLHXocRhrNI=
Received: from DB9PR08MB8651.eurprd08.prod.outlook.com (2603:10a6:10:3d1::9)
 by VI0PR08MB10798.eurprd08.prod.outlook.com (2603:10a6:800:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 15:20:38 +0000
Received: from DB9PR08MB8651.eurprd08.prod.outlook.com
 ([fe80::8fb8:7cf9:49c4:6f90]) by DB9PR08MB8651.eurprd08.prod.outlook.com
 ([fe80::8fb8:7cf9:49c4:6f90%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 15:20:38 +0000
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
Subject: Re: [PATCH v6 19/22] firmware: arm_scmi: Add System Telemetry driver
Thread-Topic: [PATCH v6 19/22] firmware: arm_scmi: Add System Telemetry driver
Thread-Index: AQHdHdtKDLD6uQlPR0ugW5SF0JlyLQ==
Date: Mon, 27 Jul 2026 15:20:38 +0000
Message-ID:
 <DB9PR08MB8651FED60EE1AD37D4FE3154FFCC2@DB9PR08MB8651.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DB9PR08MB8651:EE_|VI0PR08MB10798:EE_|AM3PEPF00009B9D:EE_|PA4PR08MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: ee03f9ba-6f82-4ed0-6f4b-08deebf2c2fd
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|38070700021|6133799003|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 7jyJ1si9AnxzMc5PkwQzlMMzzpdSQTR00Eiz18TthVp/ZE8oTsx2s2ERFTvJywTcoEqg3kKa4BfwHdr3phlNRswG/uttJ2Knw/5/K6zchv5i79h6YicVYIsmjngmiOgQWrbhkK+NoETxAWcseeNm+sZXaVkxAc03axLAOknHriI9/iM9Rf6PjgFRyUwZ6/sfk7X/b/qaC/NbHu1JXZd9O2wBOXIPbGbuG5W+menoeaRSKMsWqKkMrwnS01umfaSDZKaogkl/IHiaiYJem7gMcA8iCf6BSQH+aXZaUMoLcJFHaum8OoTwpTT/vRj6agjwOJKEYDC2oKHR5rkK+/Bmj0n9xaZ9RaP1evXoIthKiInUute7ysIAgTcnQO2QKGw8tEcmXpLD5ppCTu/nYZrehGVVh97l8IbgHYH4ylbhrSFBATXFGJIvfPrvyXnqh4yQzf2xdUb0L4qf4xDfkZN+LFaHCENW1rbDV8Q97uDFjgf64wgkacxuKAXhoDUOjHS6ue+B+Q+eS80jXIgNON5bpJ5NRns5vBlzXM1PtbSqJFcHxlol6hfpNokE2TrfhoXJ0M7wUEor6zUM2p72DoiZkXWoVng9vr9bvBMlC+w5IlrVtFuTSm3n5skXAW8MZTBzEoEgCfltwqtoUIEB6K9mo6zNm1YdZ1129+RQDYbUYBAMB1wuFOWVkQ0lBrb7/0wETKzWYaAVrH/KljQ/0x55g9VIlqLEqGCNWd8Gj1VHFi8=
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
 sHwVZ6mCnYrXagABN/itzeL0u4x2XpVRSPDHKKiAX0dTRnxf81nO+UeCmoKM+LDZELiUbUBUUarI3C/dpXkTJf7ZxTtMRmnPf9CY9dh0Bj1tTGV6lWQP1TVckP1QA2FxU8S5TepHik3y7qFiGGaNtTaeZrQx+mwyBgp3ZR45WMEBg4pKrWvDc/0lW4Q6XrKmHw1u3sFs5rq90q954A0J8bTg45qJI3HWxGrei+jm60oiCo4B/twmWRYiYFiDpmkl95GJOmTqqqnvUfEiL+qH85aqR870ZzVFWLwV4v73JShdNwu+sKRDTIURiIEV3N1mmCWzBkOFhYCmI4VOhHGRew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10798
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ab34e522-41ed-43a4-8f5d-08deebf29d2e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|7416014|36860700016|14060799003|35042699022|6133799003|11063799006|56012099006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	0C2RYuMf//SFlNqfuXa6zXS1NLTZhcfEfxJ568W+u2nsgqvAYdhR1E2LhaeUNS2/oYX9Rc7O+Byek89wGXudV8ft3y9ouMnam/hsNwf/XMm/8gCoTsSBJ9qM7qHXOKU5traM+SbatLnzLGXvqZ5/ZWQAuRoL8+S0zkUStDHkVp8AAA3wYF3qlHiwSkiufpiR7h8wDtRLe1gaJRG2Zb8oLQVXQ9GoxahRk64ZP4HneZCbXilaKIm3LDoo3GVrqfp28UvClgknIVWDCQL+b/0uL3fYLD2ANwqTVOffvo8i0a5bSXKwvNsTrDQ5K+255itFvvFpbLGnWyX4kHexOVWqWYTOt3dRXyp22sixlPKPL07prJr22Lpp+RARJl7a5KZm5ob29ABcNnehkdBI9P6wJ7B6/Bw6ktKjBTMN0fAOPr0ztto+BmZmmaAHKw7X3OkIoau5DUwf0ZbOPzXA7H6/jZ+S+5TR+ALD6cEf146iGcyaAvFtl2ufYd3kBbKuIf8yuPIx3GVGWgVQfzHtuH3Ie8XDh2uabjsd0+XDhdruVJ7HvaxjXwCXzBjNOmcv/4wy9RMjEoqHdxKuHT/QDs2TJy8dnmZ4+GANPZpjvcbovcJ4l+oxR7Xza/+UbUgDy7viG26URLyDClz72zK3m+yxyuAKKbt65z0VF3BhgePb0Lk927OR7vFdsyPy8eauIvyJBgofZM6uVDkLYYe5zy0yng==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(7416014)(36860700016)(14060799003)(35042699022)(6133799003)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JOEQwwaZlza5OqOo4u9R3DTcJjGMCCJ81S4Oub5tNp2zhegA8kufC9jjINk7Pjjumlj/vogTSGYBGAnlm9noOVBirPw3jDKG3jJ5e0zUsB9HstWlSC55BfJodPqarFN+6ygWCo7Os9hFX4hz/UUZXIa5rBrGJUTeL8o2LW9m0K0/R8eaNd1EpVZnd8K/+DCqY/tJpRSh7oUv4gWEUx/yE5PhZ/tAiNK6k3PeZV9AToXIEHKM1brHFiq6GvDaqOoOSvXJytGLW6CywZFiKixib1G6V8DBRqWocv5KZx1OJuehcU3HgXBGI1m7Sk1gfULXwXlwcG8J0N8dDY+piVIQj8WUeqZVa7IAtbevgsm6+UdFeL0FFEy/iryC/mVHmCy8avGxx8yvG9dTQOP2kou0PhlwPTc+9Po0zF5hf6civawuBjBcMAIy1GbVXaIWTLo1
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 15:21:41.8220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee03f9ba-6f82-4ed0-6f4b-08deebf2c2fd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6048

Hi Cristian,=0A=
=0A=
Thanks for addressing the concrete V5 issues. I found a few remaining=0A=
implementation problems inline.=0A=
=0A=
> +	u8 *impl_version =3D (u8 *)in->base.de_impl_version;=0A=
> [...]=0A=
> +	/* Each word composing the UUID was stored in big-endian */=0A=
> +	for (int i =3D 0; i < SCMI_TLM_DE_IMPL_UUID_MAX; i++)=0A=
> +		out->de_impl_version[i] =3D impl_version[i];=0A=
=0A=
The internal UUID is stored as CPU-endian u32 values after le32_to_cpu().=
=0A=
Reinterpreting that storage as bytes therefore produces different output=0A=
on little- and big-endian systems.=0A=
=0A=
Please serialize each word explicitly in the byte order required by the=0A=
SCMI specification and document the byte-array representation in the=0A=
UAPI.=0A=
=0A=
> +	if (get_user(usize, (u32 __user *)arg))=0A=
> +		return -EFAULT;=0A=
> +=0A=
> +	if (usize < offsetofend(struct scmi_tlm_abi_info, reserved))=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	if (copy_struct_from_user(&base, sizeof(base), uptr, usize))=0A=
> +		return -EFAULT;=0A=
=0A=
usize should have an upper bound, conventionally PAGE_SIZE. Otherwise a=0A=
large value can cause copy_struct_from_user() to inspect, and=0A=
copy_struct_to_user() to clear, a very large userspace range.=0A=
=0A=
The error from copy_struct_from_user() should also be propagated. It can=0A=
return -E2BIG for nonzero unknown trailing fields, which is currently=0A=
converted to -EFAULT.=0A=
=0A=
> +		ret =3D tsp->ops->state_set(tsp->ph, true, cfg.grp_id,=0A=
> +					  &ena, &t_ena);=0A=
> +		if (ret)=0A=
> +			return ret;=0A=
> +	}=0A=
> +=0A=
> +	active =3D SCMI_TLM_BUILD_UPDATE_INTERVAL(cfg.active.secs,=0A=
> +						cfg.active.exp);=0A=
> +=0A=
> +	return tsp->ops->collection_configure(...);=0A=
=0A=
There are two issues here:=0A=
=0A=
1. secs and exp are packed without checking that they fit the SCMI=0A=
   encoding. Out-of-range values are silently truncated into a different=0A=
   interval. Please validate both fields, and preferably confirm that the=
=0A=
   result is one of the advertised intervals.=0A=
=0A=
2. For a group, state_set() can succeed and collection_configure() can=0A=
   subsequently fail, leaving partial state. The operation either needs=0A=
   rollback or documented partial-failure semantics.=0A=
=0A=
> +		tlm_ivs =3D rinfo->grps[ivs.grp_id].intervals;=0A=
> +	}=0A=
> +=0A=
> +	if (ivs.num_intervals < tlm_ivs->num_intervals)=0A=
> +		return -ENOSPC;=0A=
=0A=
The group interval pointer can be NULL when per-group configuration is=0A=
unsupported. It may also be NULL following partial group enumeration.=0A=
This then dereferences NULL. Please return -EOPNOTSUPP or the relevant=0A=
enumeration error before accessing it.=0A=
=0A=
Also, scmi_tlm_to_uapi_intervals() does not set=0A=
SCMI_TLM_INTERV_DISCRETE from tlm_ivs->discrete. The returned flag is=0A=
currently inherited from userspace input rather than describing the=0A=
firmware data.=0A=
=0A=
> +	ivs_intrv_sz =3D ivs.num_intervals *=0A=
> +			sizeof(struct scmi_tlm_update_interval);=0A=
> +	struct scmi_tlm_update_interval *ivs_intrv __free(kfree) =3D=0A=
> +		kzalloc(ivs_intrv_sz, GFP_KERNEL);=0A=
=0A=
This multiplication is still unchecked. On a 32-bit kernel, a large=0A=
userspace count can wrap to a small allocation. The subsequent conversion=
=0A=
loops over the real firmware count and can then write beyond that=0A=
allocation.=0A=
=0A=
The same pattern occurs in:=0A=
=0A=
- scmi_tlm_des_list_get_ioctl()=0A=
- scmi_tlm_grp_desc_get_ioctl()=0A=
- scmi_tlm_grps_list_get_ioctl()=0A=
- scmi_tlm_shmtis_list_get_ioctl()=0A=
=0A=
Please allocate with kcalloc()/size_mul() using the required firmware=0A=
count, rather than the possibly oversized userspace capacity. Only the=0A=
actual returned count needs to be copied.=0A=
=0A=
> +	rinfo =3D scmi_telemetry_res_info_get(tsp);=0A=
> +	for (int i =3D 0; i < rinfo->num_des; i++) {=0A=
> +		ret =3D tsp->ops->state_set(tsp->ph, false,=0A=
> +					  rinfo->des[i]->info->id,=0A=
> +					  &ena, &t_ena);=0A=
> +		if (ret)=0A=
> +			return ret;=0A=
> +	}=0A=
=0A=
SET_ALL_CFG still leaves partial configuration if one DE fails. A=0A=
subsequent GET_ALL_CFG only reports a cumulative boolean and does not tell=
=0A=
userspace which DE failed or which earlier changes succeeded.=0A=
=0A=
This needs rollback, or a batch configuration ABI with per-DE status.=0A=
At minimum, the partial-failure behavior and multi-client interaction need=
=0A=
to be documented.=0A=
=0A=
> +	for (int i =3D 0; i < batch.num_samples; i++) {=0A=
> +		int ret;=0A=
> +=0A=
> +		ret =3D tsp->ops->de_data_read(tsp->ph, &samples[i]);=0A=
> +		if (ret)=0A=
> +			return ret;=0A=
> +	}=0A=
=0A=
On failure, successfully read preceding entries are not copied back, and=0A=
there is no indication of which entry failed. This is why I think a=0A=
per-entry status is needed for the batch ABI.=0A=
=0A=
An explicit upper bound for num_samples is also needed to prevent=0A=
unbounded allocation and iteration from an ioctl argument.=0A=
=0A=
> +	if (req < ctx->shmti->len)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	base =3D ctx->shmti->phys & PAGE_MASK;=0A=
> +	needed =3D ctx->shmti->len + ctx->shmti->offset;=0A=
> +	expect =3D DIV_ROUND_UP(needed, PAGE_SIZE);=0A=
> +	npages =3D req >> PAGE_SHIFT;=0A=
> +	if (npages > expect)=0A=
> +		return -EINVAL;=0A=
=0A=
The lower-bound check does not include offset. A mapping can therefore be=
=0A=
accepted even when it does not cover offset + len.=0A=
=0A=
Please calculate needed with checked addition and require the VMA to cover=
=0A=
PAGE_ALIGN(needed). The handling of vm_pgoff should also be explicit;=0A=
unless partial mappings are part of the ABI, nonzero vm_pgoff should be=0A=
rejected.=0A=
=0A=
It would also be prudent to reject executable mappings and document=0A=
whether MAP_SHARED is required.=0A=
=0A=
More fundamentally, mapping an unaligned physical area exposes the bytes=0A=
before and after the SHMTI in the same physical pages. The driver cannot=0A=
enforce access only to offset..offset+len at page granularity. The ABI=0A=
therefore needs a platform requirement that these pages contain no other=0A=
sensitive data, or SHMTI mmap should be limited to page-aligned,=0A=
page-exclusive areas.=0A=
=0A=
> +		fd =3D anon_inode_getfd(SCMI_TLM_DRIVER,=0A=
> +				      &scmi_tlm_shmti_fops, ctx,=0A=
> +				      O_RDONLY | O_CLOEXEC);=0A=
> [...]=0A=
> +	scmi_tlm_allocate_anon_fds(ti, &ssl, shinfo);=0A=
> +	if (copy_to_user(u64_to_user_ptr(ssl.shmtis), shinfo, shinfo_sz))=0A=
> +		return -EFAULT;=0A=
> +=0A=
> +	if (copy_to_user(uptr, &ssl, sizeof(ssl)))=0A=
> +		return -EFAULT;=0A=
=0A=
The file descriptors have already been installed when either copyout can=0A=
fail. Returning -EFAULT then leaves installed descriptors that userspace=0A=
does not know about.=0A=
=0A=
Please reserve/build the files first, perform the copyout, and only install=
=0A=
them after all user copies succeed, with rollback for every failure path.=
=0A=
=0A=
The SHMTI context kref only protects the context itself. It does not=0A=
visibly hold a reference to the protocol-owned shmti descriptor or the=0A=
SCMI device. Please clarify how these remain valid across driver unbind=0A=
while the anonymous fd or VMA is still open.=0A=
=0A=
> +static const struct file_operations stlm_fops =3D {=0A=
> +	.owner =3D THIS_MODULE,=0A=
> +	.open =3D nonseekable_open,=0A=
> +	.unlocked_ioctl =3D scmi_tlm_unlocked_ioctl,=0A=
> +	.compat_ioctl =3D compat_ptr_ioctl,=0A=
> +};=0A=
=0A=
An O_RDONLY open can still issue SET_CFG, SET_DE_CFG, SET_ALL_CFG, and=0A=
RESET. Because these mutate global firmware state, should mutating ioctls=
=0A=
at least require FMODE_WRITE?=0A=
=0A=
There is also no per-instance lock around configuration/reset sequences.=0A=
SCMI transactions may be serialized individually, but SET_ALL_CFG and the=
=0A=
two-step group configuration can still interleave with another client.=0A=
That does not guarantee a well-defined "last writer wins" result.=0A=
=0A=
> +	device_destroy(&stlm_class, ti->devt);=0A=
> +	cdev_del(&ti->cdev);=0A=
=0A=
cdev_del() prevents new opens but existing file descriptions can continue=
=0A=
calling the file operations. ti is devm-owned by the SCMI device, so it=0A=
appears that an existing fd can use freed instance/protocol data after=0A=
unbind.=0A=
=0A=
Could the open path take an explicit instance/device reference and release=
=0A=
it from .release?=0A=
=0A=
> +	ret =3D class_register(&stlm_class);=0A=
> +	if (ret)=0A=
> +		return ret;=0A=
> +=0A=
> +	return scmi_register(&scmi_telemetry_driver);=0A=
=0A=
The chrdev region is leaked if class_register() fails. Both the class and=
=0A=
chrdev region are leaked if scmi_register() fails. Please add the=0A=
corresponding unwind paths.=0A=
=0A=
Thanks,=0A=
Fay=E7al=
