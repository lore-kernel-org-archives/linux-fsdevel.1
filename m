Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794657339;
	b=BshgFkaXj2wVharqSpg12nu0DeCG9g7HPFgBP5ZWN5KgkvidiCCCQKsnAHq7LFO3ECqs
	 tmXCqxmZvbtdhpD8bMF2kQV8vTSUPObxRaof5IVmgs2IswZI2qia9HLMc/0dVUd8dbdsr
	 Ad7BKKJ5SICJysHeGILdNK3z4vhP0btTiMgC8sWYqjYK/6gl4ogDniAyrEDh9wGe/e+oD
	 uBdCCjEeTd/tBcjXMBJOPRI5IYc+Gv5dATWIzxr0cTzAWTTQkXDS7391USEXDBzHu73s5
	 77uicSsFXHjXDUlc3455JAjgmkML3xgUoyuzTHRRkRVwtA5Iky+knwD7ayo5qZAr4rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
	b=mdhS2k4MMbuwLb6QrdMRE1kiZCyw0tSpdk1YATFcB97krv2mbOILW+stNwhHgHt5QG0N
	 y3Sqi7Yda+tpchIqVnk1Ojg2r3OeaWZ+k1+q6nAft75EQnzhIG2jkvO6dFrTYf8OC0oh5
	 3mlpUx78WUVVcwLH0aBz12Dw8GL68ryJN8PFXNoFR1ZgG7VcsEdVji+kK9QubKwtrcmN1
	 07BNzuuhAgVeI6rJ7gqz138Yv06VcOxOKN70CVEeae27nf0FJvDUZIv15mtPRGTCefurf
	 m1EdQWCqqmK+Ws2O29YPDysUSIl7rSYE30cLkp/oc9yueB6K/59QtRUST9J1uAlIZ+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrTBjpIE;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B977606A33F
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 11:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B977606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrTBjpIE
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so338682366b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794657337; x=1795262137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=MrTBjpIEXzsSZaANjc7oExJhwGnF+j3pBQoJGLV3AozjECewWnT/dOn8PoCfUIeYGI
         mRgldWBhVoyoY4kjpOu/TkcCPMpetn8bMN74Irqnk0JnK5MAQS777TE3iVfENO0qNvUE
         8qb82pxhdLikkA/6tATGUpByZMee1vHTbdl6A6vtosorr3+hE9wD/mpuH76lS1WAZqyn
         nUdTyabyG8UAyWqGnpYJGfY62DgpvBldD5kNADP5MARyaYxmHHJYDsQkr6qVKrnaldzF
         KHIyaxdpU8Pcl80WjVwUUXXw+yU81KD0D8RdN7wE6Dhf//BzElFXAKq/AgQBu3vGzFII
         7JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657337; x=1795262137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=G/hdUYYKrnNgZZWek8oCX3NJvYlr7Ela8kUajMBdhNch7ngey/Xg1R1UXN/u0nXlhs
         XqmTNeWdFc7TYTDPYWvO+lflO/k1afDRqkBJX1SU2Fl+6ZOjwUBEwA7CPGDLPMxXbaV9
         jdv6Sr6OJe+o9VNaA/ZgVLiMn3Py0nW8E/84z9TnitNmGNFwExvMNRqpqxk+jE7TnJb1
         udZp3Qlzi3VazgUSiVxc1RRO/6uGJizTzNpa2u+Aq5gB2vuOahVicDGo/mMZptZu06Fa
         dmpEOv42YvkOpuqLkccBeKx5wVVXSjdIrwQwcgmmiNYG+E8r4lTGpDf6FV8XoIrUsTqq
         s8LA==
X-Forwarded-Encrypted: i=1; AL+hErGg9SYfdFRGA2uHRzXPuSWxTsWHRSyVf3UmvyJsWVH2EQyqZ7v78xydgWIKwrh/mhcrV87Fiu58VTxfb71l@vger.kernel.org
X-Gm-Message-State: APuU4Z/NaxIifF85F3fMs0j8dqD536GuzwenSY639l35IoVJvjF5qNCd
	nfg1JDejxNZvuXBqY5MqEKPE5f5zh7QV33GaAhOkSp51k+AtTa7febzA
X-Gm-Gg: AYBFou38OjGWq8EEWt0GACrV767WFrZ2EGKyVkMY471kHR9Q7nEWxoBoNGQkGhqFXin
	MJi5bjZqsyMOcKneeRdmGx24VGkvUzrnW+41Em0I59eWxvqOhKPXFNIVfbvcCVOE7kW9UAOd4oa
	SX3S0TwqUl0KZpvxtL9ualZ7NIfjnpF8GeEr1FwSeuvlR6bOOTfGgZgKFD60qKKJHqu8zXDp2ik
	qe6uq4qjUU6bJBj8iXP+P+Gi0gWRUkmHdBgmGEGQQ8IEwqKw22ND9Vn885ZeZCcq3X9vJSu2W0K
	3ak+TxWE496eVHoI6neI419agZ8alxTE2RMnqQDLkSeyMxDrUhoO1PDQ7Cj23LA23wIyJYof4K3
	VkHtxxfxW04Q/Hx+4uZJ16RNb8O2oXCRX4azfeTtzTVDzPHQ5PabX789kzjaSRuSQ1GBLZhotUS
	HkrpO4GcgNRIizmrw0fBRgw9PoL5riK5Pyh16ObGY4+5Ts5mG2NcDENsS5tMbZOtFz0KFsLewJQ
	GYgwUxf2vRsw8y5+qNvCdH72lk8e1FlaVBlhEBK2aaB5iwvgQ0TrhEgHU+XTVzYRL6Y2R9VoCT9
	jSlSHD2e8uB+uI6OHcdAyENn3TnTaZzf6m3FXPHYGOQlfzUOtDdB4g91OwOkSwsMLn/3Pb4XfwS
	3XaSqGiQtuEo=
X-Received: by 2002:a17:907:3e10:b0:c40:231:6eab with SMTP id a640c23a62f3a-c5096370c31mr441592966b.16.1794657336589;
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b41f44sm206223866b.31.2026.11.14.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Date: Sat, 14 Nov 2026 12:55:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avhMN39TECaur0sS@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
 <20261111151202.GA11391@lst.de>
 <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>

On Fri, Nov 13, 2026 at 11:25:57AM +0100, Alexander Mikhalitsyn wrote:
> Hi Christoph,
> 
> On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> > I've seen setups where people use fuse to mediate access to sysfs
> > sysfs in odd ways.  No idea if that's still around, but if so, this
> > patch will break it.
> 
> 
> Oh, that's painful. Do they use backing files for that?
> It's a relatively new feature in FUSE...
> 

Very unlikely that they use FUSE passthrough and if they did
very unlikely that it would break their filesystem.

The API for fuse passthrough is that the server requests to setup a
backing file before open via ioctl and if ioctl fails (as this patch
does) then server falls back to non-passthrough open.

The ioctl can already fail for many reasons such as MAX_STACK_DEPTH on
procfs as the commit message says, so server needs to cope with the
fall back.

Thanks,
Amir.
