Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7E485CDD
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721769; cv=pass; b=YQp+KoEcuF7RHriFGSCpWAapbebJvzx2FCBmuspdTh/JYj0HpDzIUlskaQRrI3jhzU6IqKmJ1ACBcSSSgPC2wbr26L4AFq7wSrUobFeRmliBVEaiB/7vYEtsGTaLlVKVQbQjHLyOtK6A+sU+Ron+g2LzB6EH0wAZ1z9oTJQIheQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721769; c=relaxed/simple;
	bh=c4H+AL4puqGwLT/pm4pEwIvcw/8v5pzNb/24xtEav2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSa5TFpONj2EXPHxOvQP9yxqJkRPqls49iaWt8lmQEt6yWFKMn6zt6yG7ibACeKxNz6dZENynJLSFYGaF/TnOVegeJ2XHP2ivxKmwDogK1M555JM9VPh94/H4I4zEc21IgMHCijGuSULQ4ID44TZKMylse6PCd0sFaizVluGwx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ooADTodE; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooADTodE"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b050a35f9dso766217eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 08:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786721763; cv=none;
        d=google.com; s=arc-20260327;
        b=R3XnHhLA1VJKOnmv/AbSV6OIxW1szVqBeM9FOvCi54381cdpkbKByXdGMox375UHbC
         PF/kIsnhkmIPXwWAlT1pgqkUL+ux1PyqEEh2KDaVownIGafe/Xor2FKs8CDhu6Y62/QE
         5xiJLRAeHw8hoU/3O1/yxCjG6gImFmmMalKkPhnFfSRfMQQTxJymTWSUSnleI6Bhkl5T
         PnryyC5EB7QV9EwC4PLUjhfwBEmjKRIpOere6R/wNmq74enHYRpWoZJaQr9DFgR6KOqJ
         53yuzWKmZJdRQeNb732Oi42ljliBm+LzjAf1HVAVeR8p70ccLQgDCj3Otpxt3pQnRyyz
         nAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c4H+AL4puqGwLT/pm4pEwIvcw/8v5pzNb/24xtEav2Y=;
        fh=pEtvCQAeGeQxlyzDgxlNipYxjBF3XnvJRmlbKqKOjH0=;
        b=FSZAB0DlqgR5p3QfcKhzLqQKP7RvJ+MLUu4gADbysoeW+tyUsR6/d3NGn/gBjL/ZZL
         /ohDzvTFNZ9codA4DdUT+ytThg66Ta4U3CZe1SseCzvPPoIdYpRsgTVu/KHKC8erbzwc
         3lvQuuUaL3NwKAT3/2esQNmv1BuowIo5vqC8AsYUCwbvOZY0ytT5X7PR8s+mFyQyypp4
         bOtSDyqrKyhwEPBv08H74z3Q3qcTB465mf5IkftlBer8MB1/hgowuIERAw19Cm/iDxhd
         X8JMyiI3NAQopicNPKbRhm3Fo0stAb7n3R7UR0+SDZb8rlYVo1HyWHYBNxTkgS0TvIK8
         P2cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786721763; x=1787326563; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4H+AL4puqGwLT/pm4pEwIvcw/8v5pzNb/24xtEav2Y=;
        b=ooADTodEjr21aohonAL1vdkwMdw/o6l/HArZrovJtYOciGIA6Ab29tN0YqJqZY7REu
         jtS1p5zslhhL95qPCWlM4r7Mu6iPmNBtLYSzrsSZr2DNcARZESbuqCK3WUyOBnmJPSIw
         NMJbIoanXBQRrCqhIj4eCdLEcS6Tso45ucJGgYLenAj0wKiVUUBv2man0CDEfWHnPdd9
         28iNVt7fsG3H6AA5a8gUj0TrkVE7WxI3hLI4ZGFQU4Xu0bcagWyj2NcrlBfqx7/VGgIO
         0nyVCf2AefaQnHl4elc+oF6DDuS6SZytKCYYLrrvmD/JDR7cllhdoc3hZg10MVCW7O1/
         d1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786721763; x=1787326563;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c4H+AL4puqGwLT/pm4pEwIvcw/8v5pzNb/24xtEav2Y=;
        b=ODMKpX5pOMbevCFUAVvTJp/2CkqSVDkmpuvirbaFm25U5Ob6P0l9L/WQwErVWG0eCY
         8x6Sbzm2qFd6r1fKOiDTvxdoTJXQHIm9wpWbfBTNvRu1kUUIenylR0F0uMD1YucZ0KkI
         0pVMmkNvnvlyK0qMpJKYuQFSKqy/JiWmzmQmBWWLzoiyjE98YI8XlYsdpEOeQP4EW6f/
         gzlntIm8/GA9vO6lXtttT73sIBocKF/y0PuaollWgdDIOqZTHjw6quVKzuxvxNrrVa6n
         EQSG42pyGrrV96Y19oVo+kBuZZJxEPqXAtiHQ9sIpPOfwBna9SzxBjliz/3ltrFOcg2l
         BVCA==
X-Forwarded-Encrypted: i=1; AHgh+RpehtlCBujSKZwonUIGfEIp2aF/eSPxd2i4mlG+KaaXvh56j78pybu3u0tgWdkR2WduG9ykZ5ziBvLcYO/y@vger.kernel.org
X-Gm-Message-State: AOJu0YySxsVhYPAYbavNhGTlqq3MmajR73aX5WMa+eWqNrPn9EdOf83y
	RXrko96zHqLxM6c/Lb4jflyp00XBWmPciHBDgzDdPMNdnpQa2IzmZz5o4CK7UziuKRJo0CHJcHw
	sA1Y+/6Emtq8dC4Mhdr6fgxixYiY5SQOPjulX
X-Gm-Gg: AR+sD13nlZhNLyh4oY36BncfHIIEmtWiBrZC7jfDsx2nN9UGTBAsWyrPWAZGIlvQ5aA
	Bbrd1LKqpRoCcY7vJfTu3aP0KjTqVNIfOkSDwGRcPHR0Hv/4ABIF0zT5EEqN1HgARwzYT1OniR3
	eZ/tdVR7JQoMqmEoR01FVH/tA6T+of8sGPYRClLpPF78gMMSWmwgzXSRJ8pzky+M39tEQ+rhCbW
	VXQMhbHwHeq90T3Qd8ARkmrDjqumGVU4ASQvGSS2G9WGi+Li1xlhDsbwrFkl7JeDHqKWb1fnp+/
	SfxYekFK6/J7YaAYtYTxjoLySkHvJzsHhwL7Udq7/djIzhdwlb6tHKs=
X-Received: by 2002:a05:6820:150c:b0:6a1:47c8:c86 with SMTP id
 006d021491bc7-6b0d6139eaamr5716989eaf.10.1786721762684; Fri, 14 Aug 2026
 08:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785951556.git.coshi036@gmail.com>
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
From: Chris S <coshi036@gmail.com>
Date: Fri, 14 Aug 2026 11:35:48 -0400
X-Gm-Features: AUfX_mzYtb9BIJuMN8HL5w2k5Mt2S6D9ha7J2YgkZZzhpnVk4PtV6PYfTcDSSaI
Message-ID: <CACd_6n2pG1UO=e_zbySWNMm_3=btwstaPY9T3+2QR3C-dXhO2A@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] buffer: stop clearing BH_Uptodate when a write fails
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Zhang Yi <yi.zhang@huaweicloud.com>, Bob Copeland <me@bobcopeland.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	linux-ext4@vger.kernel.org, ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"

Gentle ping. Please let me know if anything needs to be added or
changed. Thanks for reviewing.

Best,
Chao
