Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986265;
	b=IHZJR8Vo+oPTHvi/t+9xnf5r017WiIkpCBaZQNBMuB1hehG423VWulFWXN8F0WDtmFDl
	 5LeR0s326QphWEagPf9tlJe01HP6PcyX98ZsS3iTqDVtMsm/S9k6L/tuDrt1dG4Z1bgIv
	 stbtdiPUYlaEW6qlLYrDjXmz228GBS68dKySqerDiPpoUc7B/XDHQ0AP9QF2d7cFSMXfL
	 ly18iPkalc7eSiaPt/dNOCCdkGXhYc8D/GSiNpctzSd0/i/ErNz09inpofuLhr3pQv6Ie
	 sB2I1SUuFuuaAFJoBjvO+xjH2tPiK3ZoKzh2bC0vte+ySNjRAUz00ca9KRrhLrCByyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=1w1A0YYt3j2Y59sUP3f8dMzSN3FtGYjMk3VwQ7eTNTM=;
	b=fNVGZS/RlvNwKxSMrMMqJuah/kp5X9iikHMoTiXOnJbhKzMVfm9k16vfLSOW1p2pqj81
	 strfASNzFQcwbqPuM1GXBaH6cBxRdPF6bOI4QCA5g1kECIaKLrowNm57bv+oot/FQjrcf
	 x4gUXTGlBA6HLWO1Vx9c8IkTHyiSfLp8/hHYTjzZzUBcaaBmWWAcxn9bFT68GCcFcwJ/w
	 EOLbL/zU4Vm95nzsv/a9b17qLFr3mqv9gk0g6FQDpJMflffgyBVGrvO/OJ2fsp1uRrGJH
	 1r6hwSR4Iu9VgcCRAqqYJo+zqycZkA1jeuPXYVW3YXAWACf2W7Ha5LScBaz15S1cvRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JtiRUZBh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2D606A335
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 17:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E2D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JtiRUZBh
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c3fd91337baso165382066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 09:31:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793986263; cv=none;
        d=google.com; s=arc-20260327;
        b=mrnuyjD5pBcyFILYhSZA4kHs+mIvk8B6lxUoayzp+Jg2eQQZUzMF30po+QDco526ll
         JuCMpucFocHulYfV0hJzmnYFCOynZdVyf5fdVfl989fcAFzcLV69GXv2STt7SFXODqZu
         RmSMTAVH1ByaO4R/Eahm+Hgo8KFK/f1oytboVQxckT3nFlNayV8wSZKADPgp774KQE/1
         KKS6DrgPI342z5yEGcGuL9SXxbtmlxg4wasUwt4A+c4lk9PSJ30y1h28fP9TQRl+T+ji
         GkjwKuijIZZ1NNP+f+gvykPXrDyYcbpSHgq8Tb6+C+iz3LnLxgfUhZFtBgUxwdFeS9Ok
         oWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1w1A0YYt3j2Y59sUP3f8dMzSN3FtGYjMk3VwQ7eTNTM=;
        fh=St2Q9LD/hi2tWh9EcsmDtv3gDsFP5vCgC+J1E7LwnxE=;
        b=Dydt/j/i1MV/Ucm8aW/VAX3EW0a7V+eToLYACrtOmGEFJxyBNsWwOKPdGwVIFv0cVH
         QncYWEBOGhU3BT7U8LaXLzPSPD/b1GFUNBM4E/rNxPO3AyP0AQV9ivAd9WbYEkl+Vbth
         ZkH7lPLoG2HRSj9+gMRwmSkEcVWc653KFJ+vp4rtwEl7yR6Xmk0qB6kB8NBjv8H3MxzB
         eqiRmsl2EKggJLx/bBFjWiXdk3Wjs/lg/aipcrrJotcRPYO/VS9KXbWtbsxF1slLQ1XC
         1ueJJyDS03g8mVK3T0QKM3wnGKSQLhNc8AMutkoaYKjVK9fcH3YHc0l5vVAg8CbBDdMo
         WLzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793986263; x=1794591063; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1w1A0YYt3j2Y59sUP3f8dMzSN3FtGYjMk3VwQ7eTNTM=;
        b=JtiRUZBhEq8rmrwDGWUH05kEYwS9S1QWv5x6NGd1Yzw8iNIdfcCYtxnRcszo1dxFdb
         q9tHslx3a7wF+S+pycyeM5qMvxra2vnxMuCMifQxMzKfvOS33pDGc5B2inDfVPwG91Ea
         yX2GvcB44x5AkED0PFIfUWHjlES+iy7WV8zsymJhe21BKNOgiDGk2iPm0cj7t1K8rpBI
         /3MzSFoqAPqzL2YWEoBu42pFkvgiFirPvw4Vo4ZCJoWsEHhDVOoD6/3kS2Ug51KZbUof
         l4SHuZf/v89UFIpPXvtrGAg9zNT+Ws3FCL3AfD4d9SiLnJS6ydMU7UuE6FcThOwvtH+R
         GrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986263; x=1794591063;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1w1A0YYt3j2Y59sUP3f8dMzSN3FtGYjMk3VwQ7eTNTM=;
        b=V2H3CcydinXJ1CUh1fo83MJG3MFRgmlC73IC5dMKkTagWDj0QZ+c9xM+acKTJKGXCz
         ChUT6CugtqIR/z1G7zbNo60N/h+8WuQGfyalx4rWQsx6XJBhquiKmIrq/6DeD7sOJo63
         cqQGK9XU7j8lsZJxV7e0psAfV+COi5Sb+GZYmuJHAq/fix6QjczHG44BtaNWw+MuIW2y
         J/cYEiUYGpCBJeSNAPkV9S1biv2tE6KCBtmZBfApwCZQ/rXbFwsqfehBiYmU5TiADanw
         cG26ZR2Qd0MWIqKBOf6W81zzN3hz1nd8utI/x9LhHgaQVQ/IzVn5lSNINv5s66vTtSsr
         CGRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzElOVVHovEUXPj5F9AqXq1LS4urXw4k61kvOwXwt79aGfqqKE29ue+PuDBXhFzovtccTeLDYJGDW6SptSZ@vger.kernel.org
X-Gm-Message-State: APuU4Z/bzs8P4GPeBk7y2vV0/hGptt8MxwpAMWhoZzMcn+ZmI+IlA7+P
	EWlBW2xlUDJ8XHjaaDLQFIGBk5Q1uyqPq/wCWkYk+UildrCQ4bIVAhbY7H9Pahn6PsfA/+WR/2w
	yAC07Et2K2/acRKN8FIxH0DJBN18Uy1g=
X-Gm-Gg: AYBFou0zIe1aH/A2xhuuw/CB69208tHPJrcMBO+FOGqxXgC2gS49XzZYkjB888Hpo6S
	JcU3J4dpdEJybfkr/tKnQu1eh48xfdnWAd1i8HYrQ4cKiuCdarMuWkfnQH5ci4Q7dy7i8pMbpor
	PzX60E/w81avPg22ZZuUOK9hzuKRJuUItECDQUy4zr4M8wDJLPS26Y77UeR7iR7JgAzL+cG3V31
	Qa2azUrfj3vF+xDo4SaJjb+/MkPALpIXlUJCg7O3mfkajV+6DFjh14B+3J5zvDU4FiftnS5vWFQ
	r6Q2i5v+KqCIq7/vK+rDjCNfuK2X5ytKJc2nX0bmGV6Ab7JXpzODU+5oPlOuyACE4AhTqc1ZlyO
	+mRLEBSDPk75hOabZlVv4/aP1BtmAaWCzT4D0XEHGPxm3ahsHNDWzGxn29UJIL9giDLPYnDNjqn
	7gyew3TfvFEVnlcyldnw6uhCxmYO8XcEcaT86IGf4=
X-Received: by 2002:a17:907:c491:b0:c2e:378c:8ce3 with SMTP id
 a640c23a62f3a-c4d34d0b0ecmr280928366b.32.1793986262869; Fri, 06 Nov 2026
 09:31:02 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105165055.362-1-drifabdelmalekmohamedsaid@gmail.com> <au4DDpKhquR7oXwZ@gmail.com>
In-Reply-To: <au4DDpKhquR7oXwZ@gmail.com>
From: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Date: Fri, 6 Nov 2026 18:30:52 +0100
X-Gm-Features: AclHuK-I33fF8kfr0S1lbJN3JaH7H-mWL2RbJZGACBIaUUN__y3k2Wl4NUj4pS8
Message-ID: <CA+xk8n8apsFgcWfzLtWrtL2wU2R0Rn31hU68oQ_PRJK+=dBc9w@mail.gmail.com>
Subject: Re: [PATCH v3] configfs: fix slab-UAF Write in config_item_put
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com, 
	Ran Hongyun <ranhongyun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hello Breno,
> refcount_t: addition on 0; use-after-free.
>WARNING: lib/refcount.c:34 at refcount_warn_saturate+0x76/0xd0, CPU#1: ln/172

So i think this is caused because i removed the null assignment on
parent_item, so it catches
what parent_item pointed to when refcount was 0 but before the free,
and this is actually my mistake, i sent a syztest with the old
parent_item = NULL after the put,
and that is actually important here, because it protects uaf in
out_put and out_put_target,
so we either move the if (IS_DEADDIR(dir)) check after
configfs_get_config_item and omit
parent_item = NULL on the 1st lock, or we keep it as is.
Should i send v4 or you can apply this directly (if good enough)

Cordially,
