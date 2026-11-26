Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706842;
	b=JhMh3ytMvpx2qo+QquyIlQjHpmC/mQXp2K089OmbJWpAk7IxeT3C2OAjBLXjAiU2DxHB
	 QGRLzpXhhjsWZTo7khY6L35kMCfIzufMqU7OYJUgDpIKArhhl0V6drqNTEO9DSxmD0qW5
	 mocKMoZWKXuMb8lHp2RevHL3uUPJPyI11iM9UsHGOQHOKrx8Pr2eLEdYGtVbOxh5ge8Jf
	 iFE/TLYEb770TgICMO+604HvSQtAZzT3jryGRHXz7tfOR1b7D/EG55dHTJf1kpxCtxuD/
	 0nH/JyCTM3U29zImUgJLhrB8kYfOqCwAw16yaRnV73DaJ6Q+dvbzmLPD1QHXFnlxtzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706842;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=OEHmps0eUNKGl/kt8l21tfZRtQlqHVz3052EVcNzTEM=;
	b=P3n+nOpB9aXOLnd0Jkobd839lcfd5xhofbRrq5evB/SPRPrtnQb8iHhdHedHTpXLRqEC
	 iYgIcpsFNH00Qmrvzred363oMY6ovJTolB6pZa/LW0+++9BCGe34bVzw4K8MUq1kFQtfL
	 RLH7/FO/02eyERNXW9R9A5EyiRE39eSPqqo9dfkBrf+3LSaWJHFU4XO/KKxi2obi1LSMU
	 n/mTQUCAZjjlsVx/fSjA/e2t2twRSes9rkvMWrI1R1cOy58om0LlXWxE+KlL+TNxkiHNN
	 28qnG4z+XJQQxn9V0O6VCH3x1i0TRpYbCdr5u9AOwPkb6qcA5MrPdKPkRkGpgEbpnSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TtYvNF20;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6AE606A31C;
	Thu, 26 Nov 2026 15:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A6AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TtYvNF20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OE
	Hmps0eUNKGl/kt8l21tfZRtQlqHVz3052EVcNzTEM=; b=TtYvNF20wS4epGsE6I
	FcaotzxaZkYKtre7I/C/pBS6y4nznJo7BPoMFfgpSLnY3ta5JO2JvkKumzWZUh2V
	jJk2BQeVnoRfQHZhCxi7Gt8+VwXdaz9HPkJm02Ub6KBMo8MWaJsTfM+Gfzd5LfPh
	8LdWL9JPI9oQ/905Lbf1ClKzg=
Received: from ubuntu (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnD72RTwhrvq_gJw--.40930S2;
	Thu, 26 Nov 2026 23:26:23 +0800 (CST)
From: Shaopei Zhu <shaopei_1012@163.com>
To: David Timber <dxdt@dev.snart.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	exfat@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7] exfat: add EXFAT_IOC_COMBINE to append a file's clusters to another
Date: Thu, 26 Nov 2026 23:26:07 +0800
Message-ID: <20261126152607.933070-1-shaopei_1012@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <dcd27d38-60a2-4c1a-81ff-4a82e99520ab@dev.snart.me>
References: <20261124230746.850528-1-shaopei_1012@163.com> <CAKYAXd_ap120uprmarov-GuO0fb1eXEgw-U8G08L1xRJ9bv18A@mail.gmail.com> <20261126075247.850895-1-shaopei_1012@163.com> <dcd27d38-60a2-4c1a-81ff-4a82e99520ab@dev.snart.me>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD72RTwhrvq_gJw--.40930S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF45Zr1fGFWUur1DGF4fAFb_yoWxGr4Upa
	y5trnxt3WDGw17Cr1kZw18XFyYkrZ3JFW3Jrn0gry0kws8Wr4Syr4xK398u3srC3yrA3WY
	yw4j9a43uF98AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHuWLUUUUU=
X-CM-SenderInfo: pvkd01phlbiiirs6il2tof0z/xtbC6h-XZmsIT5+70AAA3c

Hi Davo,

Thanks for taking a look, both here and at the exfatprogs pull request.

On 11/26/26 14:26, David Timber wrote:
>> A sidecar file is lost in practice: users copy, share or import only
>> the video file, and matching the two by name breaks once either is
>> renamed or moved.
> I think I understand the the problem being addressed here, but adding
> something to the kernel to solve that particular user error sounds like
> a lot of trouble to go through...

The remark about sidecar files in my previous mail was part of the
discussion with Namjae about whether the kernel or user space should
unlink the source: it explained why the sensor file should not be left
next to the video.  Following Namjae's suggestion, v8 [1] leaves the
unlink to user space, so that point is settled, and it was never the
reason for the ioctl itself.

The reason for merging is that the camera records more than the video:
custom data such as GPS and per-frame exposure data, which is used in
post-processing.  It is written to separate files while recording, but
the product has to hand the user a single file, so when recording stops
these files are merged into the main MP4 file.  They grow with the
length of the recording, from tens to hundreds of MiB.

On an SD card, merging them by copying takes time proportional to their
size.  With the write speed dropping to around 10 MB/s under jitter, a
few hundred MiB take tens of seconds, which users waiting for the
camera do not accept.  Relinking the clusters makes the time depend on
the length of the FAT chain instead of the amount of data.  Measured on
a disk throttled to SD card speeds (30 MiB/s write), appending to a
300 MiB file with 128 KiB clusters:

  source     EXFAT_IOC_COMBINE   copy_file_range() + fsync()
  50 MiB          13.7 ms                 2.2 s
  500 MiB         14.3 ms                22.3 s
  1 GiB           13.6 ms                45.7 s

The ioctl stays at 12 to 15 ms whatever the size; the time to build a
FAT chain for a contiguous file grows with its number of clusters, but
stays far below that of copying the data.

> Also, there's issue of block alignment: Windows formats exfat volumes up
> to 32MB cluster size(I myself unsure of this MS's decision, but it is
> what it is). The release of 4TB SDUC cards are just around the corner.
> At most 2MB of space lost just to padding, just to append a few MB of
> metadata to a monolithic file to idiotproof the product.

On the padding: it does not take any extra space on the volume, but it
is worth explaining why it is there at all.

Clusters can only be moved whole.  The data of the source starts at the
beginning of its first cluster on disk, so once that cluster is linked
after the last cluster of the destination, the appended data starts at
the next cluster boundary of the destination, i.e. at
round_up(old size, cluster size).  If the size of the destination is
not a multiple of the cluster size, the unused tail of its last cluster
ends up in the middle of the combined file.

That tail has never been written by the destination and may still hold
stale data, e.g. from a file deleted earlier, so it must not become
readable.  exFAT can only mark a range as uninitialized at the end of a
file: each file has a single valid_size, and everything below it is
read from the disk.  A gap in the middle cannot be described, so the
only way to keep the stale data out is to write zeroes into it.  For
the same reason, any range of the destination below its size that was
never written, e.g. after fallocate(), is zeroed as well before the
clusters are appended.

The zeroes go into the tail of the last cluster, which is already
allocated to the destination.  No cluster is allocated or freed, so the
combined file occupies exactly the clusters the two files occupied
before, whatever the cluster size.

What the padding does cost is that the gap becomes part of the file: up
to one cluster less one byte of zeroes is written, and the file format
has to skip it.  A trailer located from the end of the file is not
affected.  A writer that prefers its own padding, e.g. an MP4 'free'
box, can pad the destination up to the cluster boundary itself before
the call, and then nothing is zeroed.  The cluster size is reported in
st_blksize.

> I think most of the products on the market today just use multiple files
> for multiple streams at different rate(LRV and WAV - fs/exfat have long
> supported preallocation to alleviate the classical fragmentation issue
> inherent in linked-list based filesystems).
[...]
> However,
> if you don't mind elaborating, I'd like to see some actual
> implementations in the wild that may benefit from the ioctl.

On implementations in the wild: a similar implementation, though not
this version, is already used in mature camera products.  I would
rather not name the vendor for now, as that involves other matters, but
the use is real.  The open source user is exfatcombine in the
exfatprogs pull request.

Products that deliver several files, like LRV proxies or separate
audio, do not need this, and preallocation already serves them well.
The ioctl is for the case where data written to separate files during
recording has to end up in one file, and where it is too large to copy
quickly, as described above.

> I also have
> a bunch of ideas I'd share with the kernel devs, but I just keep them
> all to myself because the kernel development is hard and the ideas are,
> most of the times, not worth the trouble of maintaining it in the long
> run. I don't think it's not fair for the maintainers who have to stay
> behind for years to maintain things.

On the maintenance burden: that is a fair concern, and it is the
maintainers' call to make.  To keep it small, the change is
self-contained in fs/exfat/file.c: it touches neither the VFS nor the
on-disk format, and only uses structures exFAT already has.  The
interface is a single ioctl with an 8-byte argument, whose flags field
is reserved for later extensions.  v8 dropped the unlink from the
kernel, as Namjae suggested, which removed about 170 lines.  It is
covered by a test for fstests (exfat/002), and exfatcombine exercises
it from user space.

Thanks for taking the time to write this; the feedback is welcome, and
I don't take it personally.

Shaopei

[1] https://lore.kernel.org/all/20261126125216.927053-1-shaopei_1012@163.com/

