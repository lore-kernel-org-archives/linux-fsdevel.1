Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51DC1A2545
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776990053; cv=none; b=GkRWN2C3i/cLAkT1vRVWjOHeAqdiZHAmxhgMJODcTvqq6KSISCZMr8OcIxhydNBZDXqeonBJy8muv0OgykCeWAI3GDvdG+Hc+9zkjnOShd4fHRPoRFDkKJqDSm+C5Ou3uWnkKZuhE3nk2kwVlz17QOFN4SI1tLqFOV1HpvFyZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776990053; c=relaxed/simple;
	bh=ZsvTnr8rmneCg+vcDnTWrnIkur6DWp7wqWbXFJZanb0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=t9o4EWyul8gzH2MJlvvWGdfFCeNKQcHQDWha9U2bRf1cZmMwcurumr8T/MIWAunRHCGErbahQCu3TRXUGJtKB4mpusYjp3a5Nr3kesa95Ecq1Ea6TyifviPF2HIMl/6DrA3CAOSfXQ4ikJEGDfd/30IbIJH0j57ZlP8gn5uTBK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLPw/nTE; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLPw/nTE"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c6e2355739dso2937954a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 17:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776990051; x=1777594851; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9prmMr/fIcHvT4Kdkrzhrvvq7KnrqsNR3KWHLAQJlTo=;
        b=OLPw/nTEc4VV/fGl72Jh3oyWioMlTarv34Z7UVF5gv52vAnYgGs8KJ5jcPmq6Ukp6X
         UiT/zy0J5ThhcHsSty1uGkPVKZZZ1lYQhP4fMZMunzwrkXkeg86EX0/TI24rpmlb8ugY
         ps/2DlMVBHif1iTKhihZ3VGWgWNodOWSR9CZt8EDdXO9bq5+5lSsKYMATPL+RgnkaXLu
         a9djnWakBlRJcxaswuZGzATNYw4pMZd+vnuULnRSZe3H+C49O3c3eHNNhJVAKAH7qmJA
         Qi78eYu/E2GIm2lJAUAzE0ig4o+VFKQ00taRTNJBZoyFIkVVrNfv9zKgaSXJcBN68kZu
         FDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776990051; x=1777594851;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9prmMr/fIcHvT4Kdkrzhrvvq7KnrqsNR3KWHLAQJlTo=;
        b=sWTeuguBpxvGo1yy7yeETVoJfo+qvWjomrC1bCPDZtDBiMHqa7zWuNDnfpiHJuAqEn
         S5yOV5JHl5LALF6oljXH50upVJNv4BgPKmlJIsgqhEd5Jiuv4pclVjABL0eypjNdeblt
         8KNhHvhYxt4rLhblQgJ3DH5yHRbzUOSsj/yy81Q18h3jj4mEqZxNfRQZpYZ4aFYipxoA
         RXsqG+SZ9lhOgwq7ONVkyJWBs/RB0hDGKU+wWhjR4oBnCqjkI0oAgqmv+gMqqOT18iAb
         T58OHJgdnnkdsYC1hEU++iiuxb/sPTc/8FLPkVmkUXtp0xAXW8ahH0c7b09qYXuSKR4l
         fNYA==
X-Forwarded-Encrypted: i=1; AFNElJ9XNto4Tk3cPv0so52xtLeyOxguz6zDUso17QvcVRWudDJPP1+gpBSf+QRjR+8p60yW/g59bR8l5ogpP5/7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/7970IP5n01RWrwL7U3ElIMxyP7gd0vzA7N6FS4q05ELIJGh6
	nYNxDa7L7WYdXlqxbqKfITRUns/4VTtSoAWxBQvhddKHSmLCTh8rOYdn
X-Gm-Gg: AeBDietk1AhgZCH0eTZFVhhe7aQoI/SxdfP3B9jsvlIque4PSx0fpQmLvdaq+ZgIqc7
	qqTEXeKjV9lKhxJJPt9MiaapIZqw8fx0WHh7XXtnR+pMZeVLPlRSxkReQ9h5bmpCRWhAv4Rwx9Q
	S+qcJgZxZHkIiwDHhFu7Q34/naZPvyoy8yvOUM9wTnzNQaSw+Ge441d34MwdsOHu5b5tSj4gCtf
	M2cId07NpBaFFUdWR1uXbNbZdfCg3224HDwcACoesUUvM2J72jFt9AlKXQdrHZReJSl3dQNk/2H
	tVAcRY4uJu3ou48NFte8ZQLikCjxE4mPF10WI1M0HcAmgAgdYLkE9iobRUE8GjYFrRQylwJfL0j
	n89kT7tQ9Xz3uXrU0U6kXRZVo38cgzW+VRKT5tQM4noiJmm7YqQiQ1ZweU/FDd8rbF2YNGU6KGJ
	iu8GEGDRGuURQtZdCotQrsovRJ7ZyRIG/I
X-Received: by 2002:a05:6a21:329b:b0:3a0:129a:9748 with SMTP id adf61e73a8af0-3a08d76d958mr31549415637.25.1776990051094;
        Thu, 23 Apr 2026 17:20:51 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f92183sm15156744a12.3.2026.04.23.17.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 17:20:50 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org, hch@lst.de, jack@suse.cz, Luis Chamberlain <mcgrof@kernel.org>, dgc@kernel.org, tytso@mit.edu, p.raghav@samsung.com, andres@anarazel.de, brauner@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/5] Add buffered write-through support to iomap & xfs
In-Reply-To: <aeqxFKaw1uOk1GuZ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Date: Fri, 24 Apr 2026 05:47:17 +0530
Message-ID: <1pg5tdo2.ritesh.list@gmail.com>
References: <cover.1775658795.git.ojaswin@linux.ibm.com> <4og3axdvzyfpfx4o2rhcnwdsggha2kfoerausxx52vd6jc2hzq@u72iwxrxxble> <aeqxFKaw1uOk1GuZ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> On Thu, Apr 23, 2026 at 02:25:43PM +0200, Pankaj Raghav (Samsung) wrote:
>> > 
>> > 
>> > * Testing Notes (UPDATED) *
>> > 
>> > - I've added support for RWF_WRITETHROUGH to fsx and fsstress in
>> >   xfstests and these patches survive fsx with integrity verification as
>> >   well as fsstress parallel stressing.
>> > - -g quick with blocks size == page size and blocksize < pagesize shows
>> >   no new regressions.
>> 
>> I am hitting a very strange error in generic/127. I deconstructed it in
>> to two commands that can reproduce the issue:
>> 
>> ```
>> $ dd if=/dev/zero of=/media/test/fsx_lite_nommap bs=262144 count=1
>> 
>> $ /root/home/xfstests/ltp/fsx -l 262144 -o 65536 -S 191110531 -N 100000 -L -R -W /media/test/fsx_lite_nommap
>> mapped writes DISABLED
>> Seed set to 191110531
>> main: filesystem does not support exchange range, disabling!
>> main: atomic writes need O_DIRECT (-Z), disabling!
>> short read: 0x0 bytes instead of 0x6c7f
>> LOG DUMP (1 total operations):
>> 1(  1 mod 256): READ     0x39381 thru 0x3ffff   (0x6c7f bytes)
>> Log of operations saved to "/media/test/fsx_lite_nommap.fsxops"; replay with --replay-ops
>> fsx: save_buffer: .fsxgood file too short... will save 0x0 bytes instead of 0x40000
>> : Operation not supported
>> Correct content saved for comparison
>> (maybe hexdump "/media/test/fsx_lite_nommap" vs "/media/test/fsx_lite_nommap.fsxgood")
>> ```
>> 
>> This is on a bs == ps (4k block size) xfs filesystem.
>> ```
>> $ xfs_info /media/test/
>> meta-data=/dev/nvme1n1           isize=512    agcount=4, agsize=2097152 blks
>>          =                       sectsz=4096  attr=2, projid32bit=1
>>          =                       crc=1        finobt=1, sparse=1, rmapbt=0
>>          =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
>> data     =                       bsize=4096   blocks=8388608, imaxpct=25
>>          =                       sunit=0      swidth=0 blks
>> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
>> log      =internal log           bsize=4096   blocks=16384, version=2
>>          =                       sectsz=4096  sunit=1 blks, lazy-count=1
>> realtime =none                   extsz=4096   blocks=0, rtextents=0
>> ```
>> 
>> The same test passes if I pass `-G` to fsx parameters(disabling writethrough).
>> 
>> The error is coming when we do a read operation which feels very
>> strange. Could you run this in your setup and see if you can reproduce
>> them? I still do not know where the issue is coming from or it is
>> because of my test setup.
>
> Hey Pankaj, I think the xfstests branch I shared might have been missing
> one small fix that can cause this issue. I've update the branch with the
> fix, can you give it a try:
>
> https://github.com/OjaswinM/xfstests/tree/iomap-buf-writethrough2
>

Ohk, just noticed your reply, after sending a response...

Thinking it again, I agree we should just always ftruncate it back to
the original file_size. Because we might have changed to file size while
testing the writethrough support.

Thanks for fixing it! This fix looks right to me.

~# git diff
diff --git a/ltp/fsx.c b/ltp/fsx.c
index c9901f65..720bca83 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2095,7 +2095,7 @@ test_writethrough_io(void)
                return 0;
        }

-       if (ftruncate(fd, 0) != 0) {
+       if (ftruncate(fd, file_size) != 0) {
                perror("test_writethrough_io: failed to ftruncate to 0\n");
                exit(132);
        }

-ritesh


> Regards,
> Ojaswin
>
>> 
>> --
>> Pankaj
