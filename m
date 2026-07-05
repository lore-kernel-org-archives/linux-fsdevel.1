Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34166211A14;
	Sun,  5 Jul 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783265462; cv=none; b=eBpsPC1EShbwAOqFWxl15RXNmp2XDXBx6L51ahuDbK6rYqCrQH3CKGsr0OlfQ1H+CzyYPp6pGfBclPY6i6XfX4+MvJUVpfjVUCA8XnXRRgy5L5gftolsp75PVkhzwgaM7t/jguLkHgbcpr+JqrnKRsGHV+k6qvImC5TjJoQOmKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783265462; c=relaxed/simple;
	bh=KhaeSJ8H2dcBuR4zI/JKQBsMdLeiuOkRa7tc4VYCiZo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=auBFHZ3XsIIf48y3gi7W/D8wU6frOLEN9NHg+k4XgtHvyNFP+ehDmI8RBiINdLKlq0JdEBR9HnAgGjHtoMczZAFXbNtl8a/Gv1H+kWc2cnqHhBRdHpggwIf/7/svRbxLYoGvhoi1MTL3KcbSsTO1Y09ftyYVPVZvoGfHkg+5fpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kEopeywY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kEopeywY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=WL4lDo2YGrNjgURafNClWjvuTQQ9JaX4Xxd5HPv51NY=; b=kEopeywYiDYHx+3LQ6UHzOQZQD
	XL9oVHpIFpuVb2IKU7K2tcedGpxmL6bpHjloHu80THx396ATta6u3BK6wE9sdXxgGt+PWRzE6NTSW
	CaiHkX0101iM1k1xneknqs7Sy+P1GjuTTbngy+6KMgXtK13sNhRc6gD/oYQJYrYu+8B5tKAwNzW0y
	CzkUwUBI4ivUqO0pyKqw+92QbdCjusQqMe4km6SXbtb2he9F/bI7uNZ14ROSBcfv0GbJdZUHio3oz
	12p+2o2sTd6ui7+Jv2raiXwqtYmaihrtUueyRhxT1df+LgLwRVj/fFlnSruVjwozSKNJhtaM3RtJW
	r2ee9snA==;
Received: from [129.95.232.135] (helo=ehlo.thunderbird.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgOnv-0000000EIsf-0UWY;
	Sun, 05 Jul 2026 15:30:47 +0000
Date: Sun, 05 Jul 2026 08:30:42 -0700
From: Randy Dunlap <rdunlap@infradead.org>
To: Yuhong Cheng <ceohunk@gmail.com>, corbet@lwn.net
CC: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_docs=3A_filesystems=3A_porting?=
 =?US-ASCII?Q?=3A_fix_spelling_of_returned_and_instead?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260705072609.1692-1-ceohunk@gmail.com>
References: <20260705072609.1692-1-ceohunk@gmail.com>
Message-ID: <3009A727-CB8E-40FF-971A-E0FD4D955547@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 5, 2026 12:26:09 AM PDT, Yuhong Cheng <ceohunk@gmail=2Ecom> wrote:
>Fix the spelling of 'rreturned' and 'instread' in the LOOKUP_EXCL section=
=2E
>
>Signed-off-by: Yuhong Cheng <ceohunk@gmail=2Ecom>

Acked-by: Randy Dunlap <rdunlap@infradead=2Eorg>
Thanks=2E

>---
> Documentation/filesystems/porting=2Erst | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/Documentation/filesystems/porting=2Erst b/Documentation/file=
systems/porting=2Erst
>index d13f0a23c=2E=2Ee040b0ff4 100644
>--- a/Documentation/filesystems/porting=2Erst
>+++ b/Documentation/filesystems/porting=2Erst
>@@ -1173,7 +1173,7 @@ these conditions don't require explicit checks:
>  - if LOOKUP_CREATE is NOT given, then the dentry won't be negative,
>    ERR_PTR(-ENOENT) is returned instead
>  - if LOOKUP_EXCL IS given, then the dentry won't be positive,
>-   ERR_PTR(-EEXIST) is rreturned instread
>+   ERR_PTR(-EEXIST) is returned instead
>=20
> LOOKUP_EXCL now means "target must not exist"=2E  It can be combined wit=
h
> LOOK_CREATE or LOOKUP_RENAME_TARGET=2E


~Randy
