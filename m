Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395174EA374
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836190; cv=none; b=fkKCs58mFQ3WNKK5T31Ud6UyTHuvPZC2230BuWO+54yYAVyYcya4yIJ4wA2eYuFCRkdAJyouyeyo58ya6L8ELtCWtD4gDzLwqGZU1w9psqtPiquwNE+t7TW56c4dXCQv//NPHYTWL7nLfKDqF1eNGiQOpESorwG4ZiQtHkmEtZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836190; c=relaxed/simple;
	bh=E/5MB9DmrAPZDxIzNkf5ZDQX8eOZAjHFk1n9mFFTl2w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=So/q+L2hjkXoFg7SbvvDEGpwX+B9ntp84ooVsXifcdV2qzU8XIy0sEoiAL8ZM4y/9bCskUtDxvC+mx+G4qmLEF6PE7j8HPFW9vWgFbVIYLiwH8fnVCMOIaRoYl0hTf3XqAb+jSjgcv2fguWKTgBpGHMSbkVg8r0MF2erWOCe01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ezThKuKF; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ezThKuKF"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-82380b0f55dso1083136a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791836186; x=1792440986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wg1Ux0hl2+pwA4qVaI3hvIFFByPMMzuli4I/B5ITH7M=;
        b=ezThKuKF8wDokh9LV126CqDkq7P34XkK2Biiu+wFZl4Jqu5AOH3ohzQx+ZNa09FM86
         lLei/mQ/hyy8kog9HVR2FUVEJe1pyM9H1I1c5b+/N5csUF9CIa3j4UWCn+8cP5LZIoVQ
         q3hcv7E6lpGLnA1dKzIJieWJUq5XQAocUCz3cqnts6ArMOCF+CWPUN7dN1tfRWurC296
         ChWyKVASsA2SD4Fqw67KHcvAwaOBQqZszVCKij7Z64plVx5bYb8Dt/PsdtxmUmDR7Rtd
         3Vezv+IAle+KoE0wT/2yoWe26a+qYPgY0eum1UwO9HZ+1zUasYuivhbyy8SaMI2HjRMH
         naQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791836186; x=1792440986;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wg1Ux0hl2+pwA4qVaI3hvIFFByPMMzuli4I/B5ITH7M=;
        b=m70KiUheYdgcGM1nB815tJ2QKTi3A+ehISIPtF4h3X3KxeeDmdvs+3moPCTC3kluOZ
         tvpgzgOvxNSPG6Z70dGbfTu1Y4Ta9ben1v5pljIrFtBSmItZTTn24NL/BJcZbInpnpAv
         HaP28FqWIJSvLZysoAV43f+zTn9ZbtdhuI6t23OEuGSNA8hikKsY3Crt6Lw6UmiI8G1j
         ec/u9WQtL5m96dUKGQeq0ixtONqWOkClzV8QSbGzduWtrRw/0gJupzyL6NL+CQgg+Vqu
         2vDBYo/w9GXkXVZv/V6gBSH+IUrWJZwtBzeDaqwKhhX/DU2QZpxOzk/jxCmlhzpiPArM
         JaMA==
X-Forwarded-Encrypted: i=1; AKwUvBzkehySJsFVSbPX6QBCCGdm3Qc5NLRSxdJM8W24lfMpkWjY8WHQ1oz1Mw8uqRMuLUqriCZSg7FKK1j1YvAs@vger.kernel.org
X-Gm-Message-State: AFq9FYK80rIHZ5AitzeFXGoK6kTuSDYQu/HI6s6S6/jH25Sy+Xymm7l/
	7MUcHogVZsTVg2h1qWTJjZllSD738+NvBFDB8+UVN7A3y2tuO2WI8DbN2nT7f/WnCmc=
X-Gm-Gg: AYBFou386iyiIYXfPQhrhTRc77U9ODa0OaiLD4P1fO8/9busRN0R5melOaPgS/l4LUx
	dgs2KVuxLgqAohc+k+I6v/C/CYzaTzVTwzoh520kPufv+ACCpHsEREJBauRB4YhMTmcbznmQHKG
	x4DBTnoQAslmZ3LQgOOzpLdQf7SxtyKdUvZYa6s9E4bz0PeB+oQu1fz7KgvVfSN+gqG1Xe2mE5G
	8J0PS70X25BeGj3S1MQs/pOTjfvSahipZzRMXHA1niD7iMFpYbx2oQeCaZBQ3unyIOkhCZUUQns
	OjtXGExuD0KXrFYyWR23UlNm1r5ug6ng0tEl3n27qrNI7k8jiz8uE+SWFUlRMmhLEH42BdB2xHs
	wPlGGxvZNo3tWkFtBLyvWo1aSUPw5H7WDNyDkzpBq2aqXuFBiyrJK7YQI0V0EwmcZ13+NQ90ruB
	46gn7V91KH6wmb76JwZFCRHOk6deeYWcf07a8/MW4iH3q1dB//4kB7gbg0eRjybaz/yx2oUR4Tj
	wSYUPY8T30mu3QqinUXv5p30/iOytxQCW7vxg3NnoOjEu9VVlQZXkLU3NeAOWv2ZE3s
X-Received: by 2002:a05:6830:4104:b0:81f:92c9:1f80 with SMTP id 46e09a7af769-83095b2dcfdmr13038337a34.16.1791836185941;
        Mon, 12 Oct 2026 13:16:25 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039076d72sm10441653a34.12.2026.10.12.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:16:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
 William Power <william.power@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
Message-Id: <179183618332.250226.7412463798702866633.b4-ty@b4>
Date: Mon, 12 Oct 2026 14:16:23 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 07 Oct 2026 02:42:43 +0100, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a number of changes. Later it was brough back up
> to life by Tushar and Vishal.
> 
> [...]

Applied, thanks!

[01/13] dma-buf: introduce initial file I/O infrastructure
        commit: b899f5d8a9594f3e5be7c481e4631521f0a6e42d
[02/13] iov_iter: add iterator type for dmabuf maps
        commit: f41f84796a1129838524d2aa542598c22822a2ec
[03/13] block: always adjust bi_offset on bio_advance_iter
        commit: dda48c57e1484f967727d827923d3fb47d6b8aa3
[04/13] block: introduce dma map backed bio type
        commit: dfc9cc23122deeffcbf562a0989c695e8505d54e
[05/13] block: add dma-buf support for raw bdev
        commit: 738881239a914b2d92cafdf1030c382f1614a293
[06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
        commit: db93ee31780323044eb5d6279d89f6ae49493f39
[07/13] nvme-pci: implement dma-buf backed requests
        commit: bb3e58f540e95ad55bc7ba6a6f713f79b4e79e7e
[08/13] nvme-pci: add SGL support for the dmabuf path
        commit: 3676bad01d84421fbf8567edafac63bef9f648cc
[09/13] io_uring/rsrc: introduce buf registration structure
        commit: fa1925e901c00b00695edd29d053564a6de63d9c
[10/13] io_uring/rsrc: extend buffer update
        commit: b497df80ba7536cffb2c5364e725c0812135886c
[11/13] io_uring/rsrc: add uncloneable regbuf flag
        commit: 10b6521fae14c5941b3fd77d1a48eb7a424ee487
[12/13] io_uring/rsrc: add regbuf import flags
        commit: b5a1e426d22fa059eaac1106292ad60c8da52d17
[13/13] io_uring/rsrc: add dmabuf backed registered buffers
        commit: 4bb797852328975051b001189f3e3840cfaad2d7

Best regards,
-- 
Jens Axboe



