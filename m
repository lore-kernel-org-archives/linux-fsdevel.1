Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A220481679;
	Wed, 30 Sep 2026 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809491; cv=none; b=sku5TMKSUmFysim+sWVVJFpuF0nVx/RkD0RcWWcsZaDo6kMULIZmuaTqygyLGBNjMlNST/16yu+hwodoyQksIjxVzMlxq4dBL7ZswFB80lySnXhMNN5/9z2riub650FENg47/hxzdf00dHli+5A06ZROzZwjvS5gPxg3JgE2Vpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809491; c=relaxed/simple;
	bh=oMz2F217fMqsTVPXqdhnsE0g6FFI/6XNgCEN/7yWDes=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=A+njCGDCrrhb/14D2ipJAJOChDupyBY2a7q8uXFwMiDXNzgt7zof9a7GXK59vB2Fyd/1XLQRUyanotFGvrk5HwlLc8l/AX70ILjtcwoAKzIwblqTJcZfOxT1ndZXDqlo1e1nLNSM+ZLFeh+abrxyECtWCQ8isrb5NJ3qd1MuZFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=QL10ZkX2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4DQjU7O; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="QL10ZkX2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4DQjU7O"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2535E7A007E;
	Wed, 30 Sep 2026 19:04:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 19:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1790809484; x=1790895884; bh=uWMmqug0mq7VACcEW7LNW3dbRgOXbwq+ScT
	nq0V8wgw=; b=QL10ZkX2H//HB0gZZNnbUwb6QTFAfgqyDp51STyMhf8nNhgj0JR
	nges8MFxKKpMj8hFqX1YdaJ7yWSJqPZH9/FLaOi9EcmUeUROAGIZdw5tgtI/oZdZ
	arOj9xm3n9w4tGKDXzB3Znc3YQxhG3z5TTSFhTIPShsU2l0bM8lK52nnaX3RScMY
	+5G9451UrW576ZE+icROxU+//MU5v3mWpyShrPQRBqnFp7lO2RBhIZjT2CMT8V2y
	fPNAygBLEY7uGmf/oM1jIp9pn1sKF8Lpb0Xr6osWvONFuFn4WvtFs9KFUXLHsTNT
	Xxoy/4afS1CuczrJ25ISiUoyaGwqwzTnwhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790809484; x=
	1790895884; bh=uWMmqug0mq7VACcEW7LNW3dbRgOXbwq+ScTnq0V8wgw=; b=W
	4DQjU7OP05qqJB4OVZX7MAtxPVV9RNXiSN/DrxrAk4Z8pa+8Ie6BSpkxdRNkn9vC
	ZMvcV2rVhl8LHp162kRwmOQy0bQjNEtp2lXSGla8T8HXe5jjKMCALJMO7Iooz1KS
	yQbeWbILrdggleXf2wTFpEyhSIlkho4aKum+qMI5aKrQSGYxY5CFLvrqdALu96XN
	uwVH/sQC33CHsfu0xcHW316KqOTqBVehNP7Z+j2ON/dnkp0HWo+l+t977VfjLBo8
	7hsW2cmE1EpPY6Lq6hLdFS7EZeqgcAPe0iANt4n7Vor/38/Q+Mr5sju6YuLFFgF2
	+8b0RRcmM+xVHcBJ5EXmw==
X-ME-Sender: <xms:i5W9aq8tTtkWjPLYqXMMDUafSaUfKII-aSJs8WPRxpafRMkqEZFWaQ>
    <xme:i5W9as-xdqF0fu_XC7gZ-IbO0RtINxt33Efd9soj67T9kUMnkxRcElQV4gSqby3hO
    uZaigoeIKcSS0-hTdDpUMnAL0j-kIRiHdU4GsYqpL_jBkZ3xg>
X-ME-Received: <xmr:i5W9aiSLYbuxOGlQjB0Azj0Z722Zu4kuIpCPIh71_VKtb63rYDzy4TZEKulDG0Jpj4lU2faKQ1DHUn-RlXmGCbhR_ou_B9Q>
X-ME-Proxy-Cause: dmFkZTEFpzdyQJ9ljtJrq56N9CiGtpRcGqGXBNM0zq0GHhZ6/Ahyq7ptTsRapPsw2cVXlo
    JLes7n/RNhwMXtPyD3boq6sSOa2D+PMVe9pwWd+wEY9xVj0wIOXO0elVIYiVfVSqL7SLpc
    QKI99TrA6s/tS1FyfEolYlopv8i2myfU17wTbeeRAycgYYNOXNefGHAUSpglMa6Ffkh9e8
    X5QuhHYJVBwiTtpCzPdJLqt8pPUsLrMMn5cLCsxSQXio3MkyI/KnBaMr/pYWu0NcwlCzt/
    mh21J8omPhaYEXVacYnHDXT/ZLlqnGGmpo8HhGHghewfPTEU6lKmyBEHbgNGHFP8OCCVdt
    0YdNZDxeWqJwaX7job0G0yLQAivEjgf/jXkGY5Hnr7noT0X5mybw3PJ1ZjbsawUCVD3JNE
    7nsg1OidC24MP9YU1o6tIq/8pR1/lfeZ9lma71E7nSSVn0rRp0lxWpDBUWn8Jzn3P3q4s2
    zfZ0wsTQlb4zogEO6yAYnWG95PMi8d48Owh20HIQ7s2WQFhdB0lVQd5UZXJ08tSM78DXeq
    iCib7dYiJCzwa0xjHyyIss6diBYzT7689n6S94R/0YmV5vWg1cKaApgvyuWSfFzu075U/F
    AZJFLiMRsMdLu/ojJ9yvkLtdJIe5JcvCvhxAxIpN3uJOZ5RY151CLrXffQ0A
X-ME-Proxy: <xmx:i5W9aocEandFwi-p6BYtGMRkkWkopXMDH7YgY2q_rSwgaNqrZEJryg>
    <xmx:i5W9auALXp4oSesAe4mW9kdZ8CsqnReeAaGYnJ5We4Uq8ixLo7AsdQ>
    <xmx:i5W9aimug3HhdWxfEB5M4aUFj9nfG8lN4wJiVXrn4tEera_YW5x8Mw>
    <xmx:i5W9ahdZMDOGFPSt4OGnu2AntgddNo780dFM_wSN7d-O-YpcmGc2cw>
    <xmx:jJW9aiZ0Jvl_5pDvUVW1OUw_oZkWXcbtg_cmrQDLiE9xILm6g0Xls6-Y>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 19:04:41 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Randy Dunlap" <rdunlap@infradead.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH v2] VFS: d_duplicate: repair comments to avoid kernel-doc warnings
In-reply-to: <20260930224330.2110958-1-rdunlap@infradead.org>
References: <20260930224330.2110958-1-rdunlap@infradead.org>
Date: Thu, 01 Oct 2026 09:04:39 +1000
Message-id: <179080947944.37859.7499013622677289038@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 01 Oct 2026, Randy Dunlap wrote:
> Use a typical list style for comments to prevent kernel-doc warnings:
>=20
> Documentation/filesystems/api-summary:20: ../fs/dcache.c:2029: ERROR: Unexp=
ected indentation. [docutils]
> Documentation/filesystems/api-summary:20: ../fs/dcache.c:2030: WARNING: Blo=
ck quote ends without a blank line; unexpected unindent. [docutils]
>=20
> Also, modify the spelling of "whiteout" to match all other uses in
> the kernel source tree and to be consistent on the same line.
>=20
> Fixes: 33d76519f0cc ("VFS: add d_duplicate()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: dropped Jan's Reviewed-by since the patch changed.
>=20
> Cc: NeilBrown <neil@brown.name>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
>=20
>  fs/dcache.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> --- linux-next-20260930.orig/fs/dcache.c
> +++ linux-next-20260930/fs/dcache.c
> @@ -2025,11 +2025,12 @@ EXPORT_SYMBOL(d_alloc);
>   * @dentry: the dentry to duplicate
>   *
>   * Some rename operations need to be combined with another operation
> - * inside the filesystem.
> - * 1/ A cluster filesystem when renaming to an in-use file might need to
> - *   first "silly-rename" that target out of the way before the main rename
> - * 2/ A filesystem that supports white-out might want to create a whiteout
> - *   in place of the file being moved.
> + * inside the filesystem::
> + *
> + *   1. A cluster filesystem when renaming to an in-use file might need to
> + *      first "silly-rename" that target out of the way before the main re=
name
> + *   2. A filesystem that supports whiteout might want to create a whiteout
> + *      in place of the file being moved.
>   *
>   * For this they need two dentries which temporarily have the same name,
>   * before one is renamed.  d_duplicate() provides for this.  Given a
>=20

Is "::" the right thing to do here?  The docs I could find suggests that
it introduces literal text.  Usage in Documentation/ supports this.
Don't we just want a simple numbers list?  Maybe a single ":", but not
2.

Thanks,
NeilBrown
