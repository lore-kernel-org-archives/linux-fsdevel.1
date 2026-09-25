Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99183B05A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 04:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790311095; cv=none; b=QgWbUnJAO64ZtROvG62v0D7/ru0C+Naja2IUnPDUnEPU6M6Gg+K+JDH9HXovZlcYd72vwM5MqWTR4yUbItqt6EPfRkhwbF4v5l2ekCRhr5JeylgDc++BNnFtndus6YvP7mKjy/7ZiG3igpiDiwG6PLY4wCgLEzLuvFBlUwETcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790311095; c=relaxed/simple;
	bh=DsichDivTPeQ31poorz8uMENw82Z8sxoMacf2VYGfEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn5Gn2pLKbxhs6rb5CP6OLfBgc/2Vg5efH2Tpd9sAD2zfDoJlKHESBTT9r0jPzzEF2byoZ9kqP0dyQgUyjETWcb3xFHoPH2MhEw/v39437/6lwlV0w7TB2InsuB9pi6br14Shsh5nIcgvBqoB8cxoK4wK04MPXWcmUFioUdGLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ombXNg0O; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ombXNg0O"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fbef5018so2744695ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 21:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790311089; x=1790915889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZ8/PUatfs3RdYJ/qWQW+G/R/sQoJ3VzSpSzDZnpImY=;
        b=ombXNg0OBoxMJwmw7rpFAEA6lFwKZ+0u/tjz/LrVRssznROFqACLuyQlw9ebGLSXxg
         7W11a/Yez3ltEvzi0w1SFc5yeVAve6irV69rZ20mdSvMExmliAAkBi4gtw9d9jDTOpC3
         1EhmsXcmk/2lxEkTPL8qmoMLH9IT+ghFsQg1Ndb9W54dAMmqdacZSKg034M3u+rGFCxj
         AziPbNm/9ZnrJYEIXUW2QOOWwbpowapnaOa+CRRWH404qir7jIF9os4xs68as3dxBZg4
         DyaYwpfxOoGI1kme6wBCRuDdquABhLyaiDKYv40FejwJqOWrHkK7QnEC5PgXCaUduCwI
         gErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790311089; x=1790915889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aZ8/PUatfs3RdYJ/qWQW+G/R/sQoJ3VzSpSzDZnpImY=;
        b=U9BCMbtI8Qy9kKxGbjPu/n3E0ZG7TULIKcJGzTICN1OWWNH2+jwQOwbLaWcKm/eQ6F
         YebEYiGVmIEsGnhgi3I9jQ+Ec9q/N4x2tRnKuQnniRiSYjYspMNkS62KYQcAeFMYsroG
         agLTXY6bgBDYyAC2u1gcsSmpK/8zTHF612Ao4CSOGe3g08RFEAPm8sXYJLJmoIzFNrJ+
         UG0DtjRvka0jYTQ7plz3XCIRuqpIy6N8k1W3YM8N6R+n3yLQ/gIvbXe5jODSSZi749HS
         EJgv26NRFb3244g77y3oRjjdoWg7TMzN+SFhpg62OCmghPj9s9x8EwHCwBTaq2ax60cw
         OE/w==
X-Forwarded-Encrypted: i=1; AKwUvBzxs6EJYEki/Fq7R3wOQ5ot5pou6chRXlhW9qyW8AUF7MvzCVhCxGyH0Z95Uc6WAG1u1svb4a4NPlclqGdp@vger.kernel.org
X-Gm-Message-State: AFuF++l9oYfubmHdQkdUQRoCVo2z/pozV5l3iYSTAzNrLaAAY3JMj0wk
	yIEk6Z3aHaap2tBIX5fkdiC+LZ3EOGdbqAD5jWZdNLHN4qL92Ue4jJlV
X-Gm-Gg: AYBFou05DrppZLwCZQIA+TK/4rUt9D0jCUzUZjkqFzjP7GNgcZMLov0QuIDT1vKmdm0
	sw8nH3+oIZhf4ArkQ+NxVy9rLJ5cVXO50IVZ/rC2hutSJrKVWZ5lSl/11hFVOG3cGRoNqLSbsWj
	DVctNkqE35OYBA8I9XqLEnIQqlcWTpe/bFIlyquqz0WjAsDSE1qkSVyscqP9okt+KUePXgFH74H
	e/doyD6RULAH9HLytmu0mBcqylo9guyfUAo6RfaoX2/5IWPuiiFMtEXN1Vlm6D1qMn792SR9EnK
	WCzjoC18o3juDAhuL2Yg9tyRfk3P4tvrxFIKYeqc+8Kk3KCXMuRF2Hvh9buwiZGAYRvJCLrXWQU
	iXYi169cqbTDtlm5deIaBvTnfv6Ior5yHrYcg8nEf//5VEmSUHxsBEIKTu9pZ0ajEsCQYvrh3Gl
	tuUJLB/YdzEXkX/PnkSNZDjjBQGLocg9G8DlFTnyrMARiqbrx5vjlUSXiLlQG21wRhuy93HqdoZ
	VwdmSJTW9A0oojTdKDiaylT8uGRaiI3HXke2CCfnt19KeTitc9erEEhJ2Nhu6wxSEyPOok7h6//
	Nce9nU+W7FPV7iBauo/3MKfTwNsBkDUVbPXWyaiFbKkC1Jzz1TfwaV8t7fk=
X-Received: by 2002:a17:902:d98c:b0:2dd:c100:313a with SMTP id d9443c01a7336-2df7e24f58cmr37942205ad.54.1790311088993;
        Thu, 24 Sep 2026 21:38:08 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90c03890sm4441685ad.0.2026.09.24.21.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 21:38:08 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: jack@suse.cz
Cc: benquike@gmail.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: reject short directory records in isofs_read_level3_size()
Date: Fri, 25 Sep 2026 12:38:04 +0800
Message-ID: <20260925043804.2091174-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924151356.3287733-1-matthias.goergens@gmail.com>
References: <20260919222553.3792320-1-benquike@gmail.com> <20260923175215.1577791-1-matthias.goergens@gmail.com> <w3rnunloyshklgq4ocr4jsullzhaey6u7odstfoyhd4usbfppo@m33jyem5jgrf> <20260924151356.3287733-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honza,

On Thu, Sep 24, 2026 at 11:13:56PM +0800, Matthias Goergens wrote:
> Either way, I'll first check a set of real images for empty directory
> blocks, so we know the check doesn't reject discs that mount today.

Empty directory blocks do occur: about 1% of the disc images I checked
on archive.org have them, mostly from Easy CD Creator 4.0 to 4.2 and
Nero, and always at the end of a directory.  One of them hangs on
for_next, see [1].  Two more examples, with the bytes used in each
block of the directory:

  https://archive.org/details/Anime_Transformer  DM_BXL2.iso
    /XTRAS    2022 1526 empty   (Easy CD Creator 4.2)
  https://archive.org/details/comdex-edu  Comdex_05.iso
    /IMAGES   2012 2048 empty   (Nero)

So a general check in readdir or lookup would stop those discs from
mounting.

In isofs_read_level3_size() it would reject none of them: no empty block
on those discs follows a record with the multi-extent flag, so the walk
always ends first.  What refusing buys is limited to crafted images,
where a flagged record followed by empty blocks makes the walk skip
block after block until a read fails, because the 100-section limit
counts records, not blocks.

No other reader I looked at rejects them: Microsoft's published CDFS
sample, GRUB, libarchive, libcdio, 7-Zip and libisofs all skip empty
blocks inside a multi-extent chain and stop at the end of the directory,
and GRUB fixed an unbounded walk that way in 4e0bab34ece7 ("fs/iso9660:
Add check to prevent infinite loop").  Windows Server 2022 and 2025 also
join the sections across an empty block and return the whole file.

So I'd suggest following their lead: skip empty blocks in the walk as
readdir and lookup do, and stop at the end of the directory.
isofs_read_level3_size() doesn't know where the directory ends today,
though.  isofs_lookup() does and could pass it down through
__isofs_iget(), but inodes reached from an NFS file handle can't, so
those would still need a bound such as counting skipped blocks towards
the 100-section limit.  If that is more plumbing than you'd like, the
counting alone would do.  What would you prefer?

Whatever the bound, only a zero length at the start of a block should
count as an empty block.  A multi-extent record can end one block with
padding and its next section start the following one; that has to keep
working.

Thanks,
Matthias

[1] https://lore.kernel.org/all/20260925042835.1974673-1-matthias.goergens@gmail.com/
