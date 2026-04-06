Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA82E1EFC
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Apr 2026 05:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775454450; cv=none; b=EUk2MqQwPj3BUrEf2kFT2tQS2RRt60IJWnlWVS2W355A0vkS5VKo91l9xfqg0SRko8V0Q53SndVtv8k76t2WPDF2OcaGC4DYF9vkAW85N+3jSk4asi/5C5p8sl8pLmUdaC/qZcagRwTCqAeoNMC40Ft6M3jbnExvnrtMIGvnU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775454450; c=relaxed/simple;
	bh=27lCfOGLG6r3/SozM5zIvPldVzzQy3bWKDp5fCqCllQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EgArSe0meTYxYofZ+uk3CYdybH+u9L83Cz1LJFgpfiacYwDCGcjM8Z9fLSwbRGUF4WbnOYnSjG39ETyBwyP0ccQ4UwOFJB0dxbKW8oXJcudCwz2CeXeegppc5gus/VfiVhZRMg7ddwmbg3sBcGt9OKZaqFQZPQCdopb89SduoAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=AoBcYi3T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LJEgYCvj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="AoBcYi3T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJEgYCvj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A718EC01CE;
	Mon,  6 Apr 2026 01:47:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 06 Apr 2026 01:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1775454447; x=1775540847; bh=uOohBy4aJKe9V4FzNGfvpwn2PgOUtJ82lYY
	0AhvpAZI=; b=AoBcYi3TtFQOlNaZEIkb7utUE3B8cZ29gtn2Oq2yb34g/+dZqjT
	1vaYzRU5u2AMGcZ9jChO9Sy7zDlB7+pqUasG/FS5xlGWfEjfFF/97UmgQ6bqOzpu
	2KST4MPLbhzimS6BGISZXoJ2Fh5NXEVTqC8lXESis/9xwOZD14hznovxK3lbstTj
	eonjPospep4fpZyKeM5yy86s0QIG50qN6nQQTlO6jW+3ykwOvl+c8OMSjTymMKg5
	uWdmuhHJ1fuGCRdc1SIolY5aKNO3EMxv98dnD3TWe1rqGuGn2/fTs62fX/gdpScz
	Oxq3T6fAo8eMNLboxw2xBEHH3SvUNmVsR/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775454447; x=
	1775540847; bh=uOohBy4aJKe9V4FzNGfvpwn2PgOUtJ82lYY0AhvpAZI=; b=L
	JEgYCvjwmpwwxdwIL8dgAXUHSLuaacHsD+wJhQaROt3JOsY8yv3WyQ2wi8Z1B82t
	vMA2ZUTX42SG4q5pLcxfrwJm3BSvhBcoj8jSJ7qml/0WQ4j2pvykFnUH66WnCL4w
	/e3U48wBb9KPRDZbVjBgVpIxehINTweTiOJZ7Bih2UUEyvzTEtJJzylqMOhUXtGo
	cqIpEXZXAhtdnFfeHIzXTmrFgOO/h/NxbzAKrK0uuN8HtSYKfOkzE+yH8sUYDV3r
	ySbzLMIzXLmiP05PdSFUhgPFJQkOxPVBBhgJgY0BBQLEPELcA175p7OG9Cm2PZ20
	1Pt8cKdevPhShL8P2NLKQ==
X-ME-Sender: <xms:70jTaW2j66QF02o5Vnw1kiDAiNNUbuNBPi-EEMKHtapaVnpGzmBTzw>
    <xme:70jTadZuPLnqUuK6U7iMVyMMz47i0PDSVqy3n9FKOdWezSC0qmONBZdy5c0__fqzI
    gMHlMk1uTA94ouoJcCoW4zK4rhtIhonffEn4PU_kd2xrPQ6>
X-ME-Received: <xmr:70jTaeAnLMcEa58xRjDMqJv-8SuXqw5YvqwKP-KKr-i5rHHjkBva5BYJnLRmW452ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduieekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:70jTaf8x8i0a0gi7CygWSIOi60ZyS7-4SepKSPhJMDlAu2mkXaCyaw>
    <xmx:70jTae9rnJYpKvkYh8SIK0rioQohsowzIos6hunyufHv_MEo228Qwg>
    <xmx:70jTaWcysVSZnSRAJBMb_87XhA3dLxFbfZsVG_evjS0WkZmSAb9fqA>
    <xmx:70jTaXF7EHbDDk-dIR2n3VSN5MzXIwZGDRkKcokU9-wOdu30L47Qjw>
    <xmx:70jTaSaqhi-CgNYY8GqUNT90OMHMxf0pV_mi0P8H6MAaK2PkFI7TGEBR>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 01:47:26 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: fs/dcache.c: bogus comment re LIST_POISON2 around __d_drop()
In-reply-to: <20260406040530.GX3836593@ZenIV>
References: <20260405190402.GV3836593@ZenIV>
  <177544136061.1474915.4475662411738222301@noble.neil.brown.name>
  <20260406040530.GX3836593@ZenIV>
Date: Mon, 06 Apr 2026 15:47:24 +1000
Message-id: <177545444424.1474915.12012620249205784749@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 06 Apr 2026, Al Viro wrote:
> On Mon, Apr 06, 2026 at 12:09:20PM +1000, NeilBrown wrote:
> 
> > It might be help to add *why* it doesn't.  Presumably this is an
> > optimisation for when the dentry will soon be added into a different
> > list.  There is no point setting pprev when it will soon be set to
> > something else while the lock is still held.
> > Do we know that the compiler won't work out this optimisation itself?
> 
> Er...  Neil, it was your patch in the first place ;-)  I realize that this
> was over 8 years ago; for context see 61647823aa92.  The short version of
> the story: we want to avoid a window during d_move() when d_unhashed()
> (actually, d_unlinked()) called without ->d_lock would give false
> positives.
> 

Right ... I clearly could have documented that better.

diff --git a/fs/dcache.c b/fs/dcache.c
index 7ba1801d8132..76726325fb28 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -595,7 +595,8 @@ EXPORT_SYMBOL(__d_drop);
  * __d_drop requires dentry->d_lock
  *
  * ___d_drop doesn't mark dentry as "unhashed"
- * (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
+ * (dentry->d_hash.pprev is unchanged) so a racing d_unlinked()
+ * won't see a dentry undergoing d_move() as being unhashed.
  */
 void d_drop(struct dentry *dentry)
 {


??

Thanks,
NeilBrown
