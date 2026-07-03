Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF2523B63E
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783043279; cv=pass; b=pwf0ai63dTKf3XuqfESv+wbK3sO+uX/NvUpobuNX7rn/dyEIFkaXJQGq6MucNAfRpAQuIeCfG9nEysrUWDKw4KM23UXYCKMX33b7hn/+U6eQsEG0sBICC3K86w7CxQD7bmIJOe7QyCbpj6mInSJcwnJpQgBr3j1Mdst/RgAX7dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783043279; c=relaxed/simple;
	bh=JLtvplRuOrV1XCd+vmBKYGpvhguS1Ynr34OsxGcjbOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0FwJm9j3Lkp5f/hG9sTtF9aDEdpoGMKjREidj9ViGqOdoSUbG13kzokIweqquD57m9xxn21VZdLuDEbvd5myiWOzqyONjQpsQKoNhaffO4PqfLpi7ADyp3D9uHGpjSpj5GuDsKdXA8Q03ENuOAy6TfMwX2VRQAa5vzqG3kpqfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dufoFZFh; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dufoFZFh"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4631679f204so708732f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 18:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783043277; cv=none;
        d=google.com; s=arc-20260327;
        b=fdG+/lpLpcQMTtBmA/vO68fmSlsn3xNQZZ77o5Vm/4fvUf7lMMoNeCqWHoIzdMUrfY
         8cKGiCYO4k03FbB3V5dio1SL9tM+CaoDIFy+g4m8cJo/5IsGm3oqVL1rnyXp5fvfUbrU
         n2oGhgCiJGKP65g8EC527lTyh6IWs+knZT+vI20wGYUaegtoeNqIeA4ptFaZ+up/JSft
         EirwiBjQU6J9MZoCrKakV+P9z5pq3AJr/zDGxwQJFLQjZkSdvThxH+mrKXXXzvWGtIOa
         gXkkZmL4lz4ihQ0S9lzEII1mJGGpWD3XRxxDqOJ/qMFqhjGz1dCXGedryeZ2b9WVD+y5
         bBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DOn6vRfEsVTpudhzzAfawUs56a4yn/B/CVb7CXUItZw=;
        fh=JnuMEEBe0xXtJBn1L8gCzs7xXg8Slj/kRMQbnX4GAGA=;
        b=CudrkZuOvf7jnJS6i9W+yN7aFtIUgmndO4ztidB3j98kx7ypkG4p5znPsI78IvxxRQ
         2sSufP+H0c1ppL6Ufzci+vDRCD+6JhkQOkrTO00bCHQdMQ57l0aKveW63FF5PVxWGnh3
         AfAVMb5c06p2m4kBtSUhzMPsZaO7pOZQVO4IeD/ZqybGfK0eS4GappevsaspLZijLSEQ
         w9xiC76SsIXU1mk6FRFET8vcz5Yqe1aYNuJmZvvBI7CL8MIQveLqIpMTE4eog6Ww/fQR
         2GoFoqLBh8MSvbZJ1nxqEyZ/uDIaCCro1gF4Rt722qjZVie6/FUdov8pcYufz4dJlpuH
         IwPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783043277; x=1783648077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOn6vRfEsVTpudhzzAfawUs56a4yn/B/CVb7CXUItZw=;
        b=dufoFZFhKQJbHC9rHylIz0aof78rVCYT3QUD5mRkGhy2l7H+cJFcrmx0ybWXWVb0Bz
         lrW7QlHAltzBw+kvMLizK0YEHAsZoyWS0+XBAoIi5xhndr82fJHS0BTO14xA2bp0pF09
         V9ZauT/73+0QwIKwA8dZRxz7vTpOQodLMGz6+b6JtbzgHZWnE4U3ZSPxEiq9b/IPAP61
         XgxOaQaSXfFyC+6XiKajOM6iaFL3E6uuC8U+Vp4QxuvemfkTSW28CH+qwU8M2vcSQlbp
         EcQ0Cc6bpR44VXn7DnhTNgPmvFIcLFMk2xzoNdLcWJ+zRAytywpl/r3mFm9GN/af3ipm
         Fn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783043277; x=1783648077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DOn6vRfEsVTpudhzzAfawUs56a4yn/B/CVb7CXUItZw=;
        b=nwHu2MZKSsi15HRfeIwS1+soWadiUrfqEbd/0fKfhQF2q8ctmdbEM1WnjAUe7yx3ym
         ovdUS9OCazuAFBkZkaag9Bvwew1RRCbExp5lbCdp4fosLpmDujK9Azyn5JOxRxlHYvS9
         1CQ412wPIU24EoJVCI759q8Ls1y68cPM7X60MepixLeP2+ccTFR2S7M2BDR/X+vDd4kB
         Iya6F5VTqJFs/B1La85NgZSaE2Wd4fNcNhfo7ooWc4SkvAJNKszZc/dCqH7OKveDaRDv
         Aad2OgiBsojyNIfM2gbAxhZT0eAFyMxwip7msODyxojf3ZWKUVr8YiSu+eWAXT99zFdJ
         55HA==
X-Forwarded-Encrypted: i=1; AHgh+RrLr90whr0FkHEZGz001zRd6Xdd0LF9X24ffh9HZTt9FTM8XXTBaLxjiKOtUkV3W5OmdOkV8+rMd1IAOiD+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4aJK4hcffkAzjqryICkbUEmA/rXiSSHDAaQLw8gaQ1j79W/h
	kwKNqaaXq+/lTZnGwB/F9GmzlEfFW3bEHov7+CGoFUYBPdD5TTlkSWnIV1exddRYpkiVv8ApprQ
	BRH10L6+HPBWr/OOesb+omes5kQRFFYY=
X-Gm-Gg: AfdE7cmra258GB6VH0vg2eiWkflhHZvHC8s9MozhXPYHdO8lekgEIo9QhfJ6UsnEMRX
	bp/LAxME+nmRL7yuiwA8PiDUDxWpKCJrD6XLyK/QFbdoXdVFMXfCMA417x2Dvp4/yBllWrVfz6v
	FT9uish7jXGTtCURFTQokK/7cOsZWst7mi5Eg320dmy8e6oyubVHKTjKVefFQeXuQLrWpogOV88
	6L6hu49PCh6NHETtYI7exmVZVj8xSrank3N2mxkOkC7glfCLx07c1CCYUwL4H+swYhD+Ez7Y0VN
	iOgsKNrbJqSGkqD320Kx3xGnnqgkHLlPMb4fuF6i+VF3loYBiBOr
X-Received: by 2002:a05:6000:188a:b0:474:88ef:cdec with SMTP id
 ffacd0b85a97d-479347abc89mr3414307f8f.6.1783043276701; Thu, 02 Jul 2026
 18:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-18-joannelkoong@gmail.com> <20260702140705.GE21339@lst.de>
 <20260702165117.GK9392@frogsfrogsfrogs>
In-Reply-To: <20260702165117.GK9392@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jul 2026 18:47:43 -0700
X-Gm-Features: AVVi8CdwjVgCnc8OibEiAJiLFqrCHykAhTtcw0AOMmm18cQj3dSCo5Q-SEBvMhY
Message-ID: <CAJnrk1b8j5WHtbHOWNXc4=QBFOxde1f2QxTOeui7Ta8O-xWcTA@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] iomap: pass iomap_next_fn directly instead of
 struct iomap_ops
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Dan Williams <djbw@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Chunhai Guo <guochunhai@vivo.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, 
	"open list:FILESYSTEM DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>, 
	"open list:EROFS FILE SYSTEM" <linux-erofs@lists.ozlabs.org>, 
	"open list:EXT2 FILE SYSTEM" <linux-ext4@vger.kernel.org>, 
	"open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>, 
	"open list:FUSE FILESYSTEM [CORE]" <fuse-devel@lists.linux.dev>, 
	"open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>, "open list:NTFS3 FILESYSTEM" <ntfs3@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 9:51=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Thu, Jul 02, 2026 at 04:07:05PM +0200, Christoph Hellwig wrote:
> > Looks good:
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >
> > In terms of merge logistics, I wonder if we should delay this and
> > the previous patch to the next merge window so that we can minimize the
> > cross-subsystem merge pain with more file system iomap conversion.
> > If none of them actually happen until rc6 or so, orif  the merges aren'=
t
> > painful we could still pick them up late in the merge window.
>
> I'd say everything but this patch should go in during the merge window
> for 7.3, along with clear instructions to brauner/torvalds to expect
> this patch to appear right before 7.3-rc1 gets tagged, to clean up all
> the other changes that come in.

Just to clarify, did you mean this patch and the previous one? If i'm
interpreting Christoph's concern correctly, I think he's worried about
other filesystems converting to iomap using the ->iomap_begin() /
->iomap_end() functions still? That sounds like a good plan to me, for
v3 I'll submit everything but this patch and the last one and then
submit these patches (and any cleanup ones that become necessary) to
Christian right before 7.3-rc1 gets tagged (which as I understand it,
is when the merge window is about to close).

Thanks,
Joanne
