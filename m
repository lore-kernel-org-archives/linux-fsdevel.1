Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011070.outbound.protection.outlook.com [40.107.130.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6FD34A773;
	Mon, 27 Jul 2026 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.70
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165625; cv=fail; b=Hcvq3zlUc8x7UdzKjo9FM2N7jTceJYeGFQR+dHF+iGbMEZAD9cqRcu3kfIvLZgPdrRjeke8mqisw+m8qhbn70rrS51RqEdTbr+vo0435vMq1vB1rDE7aUWdSzfDlnBGUhe6EuHo2SDCLaZYxp0Bbu0IOV3+IWDVBb4WssmDSiH0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165625; c=relaxed/simple;
	bh=JIWnjCmp9Nbs5qIDhDKKC3l3mA08dBbAOb0/J4db8AA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qTAIA+Pe5k7R8sOeZfTrYq0SfH7SrKE/yD2loNmVR6nSzEp8zI5pMB+s5xZgYqYjXDviFR8bZ4jCZDkkVyNThmYZ1niuB+7jGKHZuJGUvJBQ7Jb36/+sm+E3DLQcJwv2WlQxUmqgA43waHFqoKVsfKyX88QsYcuFtIv7tSlPJz4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c/6/iSvx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c/6/iSvx; arc=fail smtp.client-ip=40.107.130.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c/6/iSvx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c/6/iSvx"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UKj1Yj2h6u4rCXN8MXfKL0+48gw84i3YV/8O4avU0zyRHHeKY6/WcZLA1wA/H5fOM1b5igK76WWPTXCyh6SQhpx8sCt5zk76tZSNwhZVUVK3LAnUkuOdsmicv4+tdsmAVas1EHQYpTq44AMCl2fbFIzAs3vET4fQWJUuMzWjgMquC1oKEfN8G6oCYhnci+qusxW/KXqOyn9ULnUyfIgyYa0A3Woi8zCh8XnKC1NLQMXsBe66zPqOo0ScF6zXVfBwuolJT4gkfeR97dmtYyputUC8oIzWmkAt3JVZGYolSijZ1j9VR81CXqfkeIM2agR7GJEBHATU0vamjovr4KN9uw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8LH2v5WUiZRTNBp34Wg2QeZKDJKz78dxaZiy2MaB9g=;
 b=iTpnwhjaZZsb1ZdnHpu2J0yw4eP3XYCKaYpkkgtKdVC6KUnQpHOR3HCONpAYES5V0jCaek1qX3hNr6a+XHSUfwpYcjB2WhC8QFvp2uXtZmPTd2EPZ5bPksNdhqr0L6b99ZpYLH2nkER73v370gUz0+895X4E3wyjp52jYJjKPMjHqGFhAdV+shOc5g1NJ5u+UUlPip2FIQtEMrVej3OkFSREMInXRBSiiGq8vBsKSdzATl1BGWD/i3zxIol2oDqupEJtYvRXQ+Uvg0YygFnZVXR/qTAcivRfEUzeh4cUModyJQtoOjyk3Ev78CjP1RPB18e2fuARhhshO9GrePHA7A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8LH2v5WUiZRTNBp34Wg2QeZKDJKz78dxaZiy2MaB9g=;
 b=c/6/iSvxQ3SrMjvOs4E3GLfAzRRx6CjcNtsSL7AfJHif6c/d4KSNEEuQCNtPWmzMf7K+W91+v7rLCcyCyc7umdzro+4OIINNhUVW4mzh8/yGVSTestelYFnVLCKwR3zy2py/5+b1tDqa58t5eeS0cNRPQEDiQmTVYHxcjOuHA7M=
Received: from DUZPR01CA0281.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::9) by PAXPR08MB7441.eurprd08.prod.outlook.com
 (2603:10a6:102:2b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 15:20:16 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::68) by DUZPR01CA0281.outlook.office365.com
 (2603:10a6:10:4b9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 15:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Mon, 27 Jul 2026 15:20:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOIngJIxM1XfKAT4UHpq/4AGQP+NPX53/xWZFbaXqPD7TdCs0sj1koZsydmjf8MBUqTRrrcdKiqGEtYaj4xyd1rmMCT0MlaUPG5N8gzY8QTXwMFE3pm5MxRG1XyxJ7BlMNIKsnmfCKh9NG6dIQjn6K++FdiQH0DTkkdsMSX6lCW/Rfl5GzvhqkEwZv6SuKpK1VQkuHLTxQoEVVk2ecYjXi4a21XVx39Kcqrb/CNb3JDMpm1Jo1dqJ/Xb8H0sFFoAK+i6GprzoZHPu0suahOUZmW78os4dBQIbd28+YhtT7K+pCdhZeE7r5EJmh9326H9WJHXls34GAazZEpj0BSssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8LH2v5WUiZRTNBp34Wg2QeZKDJKz78dxaZiy2MaB9g=;
 b=nFVWO3zMosi8YjY4dLk23wAghHeRfEUsnt/dQrzd4FBZzTWb4bxYu9X6qXk3QgEyLhKQ1MGHOfoo1PgC+wDXc3bafu7OC7IhByg5MefyKox+6kDyrsBvwbaOp2aNsJaoNsW8YFW/33xk4AAqx7Pr2Qv9nG2vqhV0M8peHBfh8zl33VrSzReIFhgCzN8YZqQHtK35W+qWFD0u1fkde8bcFJi99eDQ02mhcWTdDWEkuYRPDzhIfUp9R6abvY4x3VJoOBnS61I4UVHzn97UDP+GmV22bFviKGepxh93B/GvCuVBkzuqJtOPj1Z9oUvRdYwbc6HORhcNzmohvMo7kkRwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8LH2v5WUiZRTNBp34Wg2QeZKDJKz78dxaZiy2MaB9g=;
 b=c/6/iSvxQ3SrMjvOs4E3GLfAzRRx6CjcNtsSL7AfJHif6c/d4KSNEEuQCNtPWmzMf7K+W91+v7rLCcyCyc7umdzro+4OIINNhUVW4mzh8/yGVSTestelYFnVLCKwR3zy2py/5+b1tDqa58t5eeS0cNRPQEDiQmTVYHxcjOuHA7M=
Received: from DB9PR08MB8651.eurprd08.prod.outlook.com (2603:10a6:10:3d1::9)
 by VI0PR08MB10798.eurprd08.prod.outlook.com (2603:10a6:800:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 15:19:12 +0000
Received: from DB9PR08MB8651.eurprd08.prod.outlook.com
 ([fe80::8fb8:7cf9:49c4:6f90]) by DB9PR08MB8651.eurprd08.prod.outlook.com
 ([fe80::8fb8:7cf9:49c4:6f90%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 15:19:12 +0000
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
Subject: Re: [PATCH v6 18/22] uapi: Add ARM SCMI Telemetry definitions
Thread-Topic: [PATCH v6 18/22] uapi: Add ARM SCMI Telemetry definitions
Thread-Index: AQHdHdsejyVYqpmVjE6FEN6WZ4GGkg==
Date: Mon, 27 Jul 2026 15:19:12 +0000
Message-ID:
 <DB9PR08MB8651954F103929073F335001FFCC2@DB9PR08MB8651.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DB9PR08MB8651:EE_|VI0PR08MB10798:EE_|DU2PEPF00028CFC:EE_|PAXPR08MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: eff98e30-a443-4580-0d7a-08deebf28fed
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|38070700021|6133799003|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 LfgSJGpOwoqJiJbIlN/jwu9rAL02Klv4pPjZC4ibDQ6T8QZU+T0JYu9zaMKNm90cT+aOfjiEkzPWxDcxqBhc9/JoUmQpKKzXoGXubqjN7og5UCdReMBoOvrXI74fLfc6Kjz1MDNurolPaSO7Uy0xEl9QhPVPvi5CPpybith0axZ5vNl8BjoV/Ej6YhB5wDXcO+tDL4kopNRUA75QCMxScI3FEQMQQ+N+OZOpO8cRkJiMRj/FLvQPlLxuG/XpX7bfboMHwRQ2stBgIPRoJiwYlRDHGj1BtEJYEqpyayX8mdPufzMI2Sktvt0GLqKgo+dGCCNyOy5lP3gt7m8AqK/GzIFIcGes4EsyQqF7spVoSBAnDojZa9HdgR8xjJeRFOz9lCML0FPyiaUg1ZEEaOZ2ycM75Ll8B6ygVMoZLAYSM8CkhEno+6zB9sM4lS+E4iROnpHy/f1gDty9px3it6sa6MGZst2dzqQaua5whTaHEdg8icncS/M1cN4KB3CyLK8LfcH0Ox6O+JhTxaLRsiPtKtjzzJpCi56ysFbXaiO068jai3aTOMnzhhzWIONi66rN73u4J5YVnfpiW1YVvXi73xIa+EHP8NiGEF3ieh2gOhA1VkQpiBMQStgKFufdGlhXbGjG8YgRvdGL2IIMDzbeVAc720Kc/zRKH0nJ68WmSOr0F6jbgLCd+h6G4NguYGXAePf0O0MwVsLUDozUXyb1a5MAPtAsB0h8zvF6HFKLB3g=
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
 izpCWP0Gw2iT2ylaX3GsOZLKnllvNA7xgpSvl9m84wkz1F2GRyVPTd96wxSXm4dsrinG28tp7JW2Rfo8WrKDBXPvvS0offZS59UWLjFCv/xH95AK5aMsq931EaXTeJj6xmZI+CyXxlRWLTmbvu3rIBgCJStZAqnYD5/8NZE6HL47IpO+YIaofYzqsdKDsTv73501xBOXVSriLsquD1i41shoJieJGftnGiKnihK78MUnowC/mv7fYOwW1FiYsQGCVxZowycPh0m+Qp1Q1fHf6ts0/yVXZiuRAhDf1Lntn1Oj/gPNin7YmQtBkozCidDJ39cSy+7jSa6HTWRSqSYBkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10798
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0214a052-fc9e-43db-373d-08deebf269c8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|7416014|376014|82310400026|35042699022|23010399003|36860700016|1800799024|6133799003|18002099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	87zhof+oLK3dFAQVZBC1GXzJbbqJc0IyAq9p5DPtMZtQIWDIluI5uJlV3cjksjJcDe8jbaEvLJYRWS3xSdH7CyXJY9UEvgg0fxQpu1v+/otnFmnfDWEyxGygEr4cG4Ld5K0EkoUC6JXnUiqZSK2MFL5yxkQera8axVJu52vJ6SDoi258eDhXrrphZTUo6VHwi0O44gKd5mS9a8BqVOpFYVQS448Pr+eunHcxHMswg1a3EA99XSCL8mk09zf+7kts5kBmywOiW1IhsvmT6W1rltBkkbWxTxKL1zW9X1VP219uMXHz9QQa3VMM4+QLhBwALtWic6ZQ/n7jUol1Ijp8leAt9t5UVUluUzDHsXxqZYYFkh+iDORxF9oi3ZZaFcF84LO0WpsTiXUr7RmNxk/LWrCAl9+GFAxSSojRTX/lrLeEcajHs7Pw7qCVqqpSBgD8Ue6jZu+QMx6/7hqTKXjJ0uxzu1orRVq7bwEaRWRBrRNM57TrIQ0gEHULUTZF3DJn/egIHSZ4gZh9g2TxRDEoxkCufuauSqWrqH1bqaQwc5+39ckva63QN2YoXgCjt6+97n5v3eJJX0UD7EGLBxBoLuQNdxN9FvFRkyYvyXUlGWJtpS5F8RaRNlQO6rRCds//heeXpbbzTRYsP9zVvN74C+oaB8YHhDdPyQqkg3Ev4tPYYEQp8mCWyeNR3DWWK8s4IScJDlcXnxOgQtO/CibANw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(7416014)(376014)(82310400026)(35042699022)(23010399003)(36860700016)(1800799024)(6133799003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zfmvx9QYu7q1j1YHKGDFwcmObz4k6YhKyBPXk+sETQhioT4XLBKlzFr7rhVntFikdy4xTFLe+BdvLLRNRA4zHJM0PJjPlyrkSnehRWWVHSjYECyjsbdMjl3F0432S3WCfZ31CiCGbQvwaYVWbKPhiasRr4wBvQUZZGiW1GzkK0lK76W9h5/H8GU40/5KQIXfvoOasr7Tp3pwjKZoYdokg8QaNVXtTxgwAdNGLV7Q9w+DkQdTroWZTjCwZMnmzJ9oyoaZyQJ8owbsCvA92zGTk1tOp8O5xTvFLN8A66+1JE7OaCKdfm3IkggWFq4+fj8SMeh/GLga4LSL4gTjm4ToOQs65Ovwy5I5EX4OeaKh2AByyk7RDEIvIeyZV4MN7HrjUgMc86EH7g7tlF87jFS5c2/ghQr7RDKzuyMi/cUp6Whu2lovkzpSBbg2hfr37j/m
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 15:20:16.1510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff98e30-a443-4580-0d7a-08deebf28fed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7441

Hi Cristian,=0A=
=0A=
A few inline comments below.=0A=
=0A=
> +struct scmi_tlm_des_list {=0A=
> +	__u32 num_des;=0A=
> +	__u32 pad;=0A=
> +	__u64 des;=0A=
> +};=0A=
=0A=
The input/output semantics of num_des need to be explicit. The=0A=
implementation treats it as input buffer capacity and later replaces it=0A=
with the returned count, while the kerneldoc only describes the returned=0A=
count.=0A=
=0A=
Please define the same contract consistently for all variable-length=0A=
ioctls. Ideally, an undersized or zero-length request should copy the=0A=
required count back before returning -ENOSPC. Otherwise userspace has to=0A=
obtain counts through several separate, ioctl-specific mechanisms.=0A=
=0A=
> +struct scmi_tlm_de_sample {=0A=
> +	__u32 id;=0A=
> +	__u32 pad;=0A=
> +	__u64 tstamp;=0A=
> +	__u64 val;=0A=
> +};=0A=
=0A=
BATCH_READ still has no per-entry status. One invalid or temporarily=0A=
unavailable DE fails the entire request, and userspace cannot determine=0A=
which preceding entries were read successfully.=0A=
=0A=
Could BATCH_READ use a batch-specific entry containing the sample plus an=
=0A=
__s32 status? This would also leave the single-DE sample structure simple.=
=0A=
=0A=
A maximum permitted batch count should also be defined so that userspace=0A=
and the kernel agree on resource limits.=0A=
=0A=
> + * Used by:=0A=
> + *	RW - SCMI_TLM_GET_DE_VALUE=0A=
=0A=
SCMI_TLM_GET_DE_VALUE was renamed to SCMI_TLM_DE_READ.=0A=
=0A=
> + * Used by:=0A=
> + *	RW - SCMI_TLM_SINGLE_SAMPLE=0A=
> + *	RW - SCMI_TLM_BULK_READ=0A=
> + *	RW - SCMI_TLM_BATCH_READ=0A=
=0A=
SCMI_TLM_SINGLE_SAMPLE was renamed to SCMI_TLM_SINGLE_READ.=0A=
=0A=
> +#define SCMI_TLM_BASE_SUPPORT_UPDATE_NOTIFICATION	(1 << 3)=0A=
=0A=
The ABI advertises notification support but currently provides no way for=
=0A=
userspace to wait for or consume such notifications. Similarly, the=0A=
generation counter added at the protocol layer is not exposed by this=0A=
UAPI.=0A=
=0A=
Since these are already listed as ABI TODOs, should the first version=0A=
include the generation/event interface, or should this feature bit remain=
=0A=
unexposed until the functionality is consumable from userspace?=0A=
=0A=
> +#define SCMI_TLM_SET_CFG	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x02, struct scmi_t=
lm_config)=0A=
> [...]=0A=
> +#define SCMI_TLM_SET_DE_CFG	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x05, struct scm=
i_tlm_de_config)=0A=
> [...]=0A=
> +#define SCMI_TLM_SET_ALL_CFG	_IOWR(SCMI_TLM_IOCTL_MAGIC, 0x0A, struct sc=
mi_tlm_de_config)=0A=
=0A=
These implementations only consume their arguments and do not copy=0A=
updated structures back. Unless returning normalized/current state is=0A=
planned, should these be _IOW rather than _IOWR? This should be settled=0A=
before the ioctl numbers become ABI.=0A=
=0A=
Thanks,=0A=
Fay=E7al=
