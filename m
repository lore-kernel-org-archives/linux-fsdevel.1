Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999415A86D
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 05:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216348; cv=none; b=QQef5DLNzHm6PJEVmo5/rS5gWadXoNLCmGGChLEMGHSg8IJ0yIcDs+n7OpONl0NmqoddSZWG3M/QkzBOnkKtArYl9vfA3ombnzr1kbAEjeWv7EJ/C/YQnYf7Jx3orkOk30/WN+pj094nknLwN+Y29qlBDrgpcAM2cWusU+D11fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216348; c=relaxed/simple;
	bh=zEfKElDmqeC3lqlwwNQaWgYZXm9HUEgqpQbdsNE+vX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNBxS0Jl2LpRG8foFHy8/UoaJp2lu7FW8Eta4TJ3Mntk9NEgUsqsj1Ad9oaD2iw8V3+k6GE432MueSUWAK05gjH0sWr8GtCsJKKHCq1wPSd0h0cvq39FA8Sa2UM2hb62KALhO4vLqFEZwkz2/zvPjqSNoPyijk1flXbbwnY9pVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6XdhYNw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6XdhYNw"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0006ea8eso24693191cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 22:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785216346; x=1785821146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rBznR6Jhz6jAQdgNETeOJVk7gwSsazLfaU1tbs21Zf0=;
        b=H6XdhYNwpmNdC2t4KQaY+4qMZzmiIDkJ+cvxruu9IcMI4qfRfcjhzGSJOlpx0EH+bJ
         rTl3friYK78E7vHIBiFft6dwTWunKodqilltuZW2DnTcaxQZJr7rfQ+wqaFHmr87FPMM
         BrWJ/Zfx1JR/yzwTe/dWAx1Sj2ZPXPQmxMCmzYRBccPZGA7wofqDnhh7aSuNXM0Dkqd3
         F/NSlJw11eMLjgjVZNIUs6VGCbMQoqp5+6Xbf/4tlsoRZAcj697MoXd3GKjcTMl4vjYq
         t54S6QOq6Vdm+AaOEKYxnp+hYM0K0JcZDLhho4TyrMgH9QvXCjRM0Okjcqe0mcriHeuz
         zAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785216346; x=1785821146;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBznR6Jhz6jAQdgNETeOJVk7gwSsazLfaU1tbs21Zf0=;
        b=M3HMGffnzkyzE+dB6bpMEuptGxuO2mpoOLnyAmhG40DrT8gcHumCc0oYau9k+QXMIy
         HJuYKLX8AtVOUIAfAxKxoKrs1bFzPP83pWfpgxL5ATYkoS6071zrrpfD89Y64tfXN/Wn
         UdldIwFudBd1I2pTghQe05hXuwYiTMafQg5meNIa0QMCSlYsg3Ap7afsOoGmxGfwRHHt
         Ad4AbM3lIMerBMjnztlCfJEyTrqyFZ/7wQr74yZX7vsmUPTYoj6rH0XD3rTz7f/8PS5b
         E+DGAOF1BL/FOo2Y241gc1T7npx7jnVnZZeucj3+OMKFlCr32s7fjl2e7TFHVrk+Ou3Y
         Lp9w==
X-Forwarded-Encrypted: i=1; AHgh+Rr7eimkB3npQMgA26aL9Ugv9tNAEBUhTVV83Aj3Fzg7E6prArW1spTu00t1zy65JLYSv+O0d7/20DzKy0oQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi86N6+efse75JX94nHaimfWZEESIc0G0ZYPn0foOcudb2qf31
	29YKojc1ZtY37NwK4+kYKzqQBU5ERw1oiERQlv/hSGhACgTUn/QwbVeA
X-Gm-Gg: AR+sD11yQtZEX2oem5yJAu+Ny1T4r7Md+Q4ZpncN8P9F/6gvcnnuSmNJslFMWWxsHkQ
	CmN9uYuWfErFQ4Mt/GLhk2xR9WpO0+mg9V+dRdJ8NDshv0nugOJt7GMT9C2ZtwJ9QzeNB/oQAlX
	7cZU8kbyflJIVUEGOjLPmIPL0u9T9kbdbFCkiC3it8T2sB2GzxBTrpwK8edcD7LewOQVcMsJPeP
	Sqh0L5wMq9is0Q+AjvsUS0J7tALFGl8fUb75yZGm9g0eOF1861mpy+msTaodT4n4Agt210yNcUM
	UA1pOKNv8blqAgV1dQzusd/0DTiVfg4KsZQ84afBdR9jc6qgpK2NB0nek4wShPsqn2QE8zsZa2U
	UTL59i4baGi0ejC4KRq6hR9zzWSyhxDWlwVH58EJREO0DL/cT7qw0p6q6jYjnqkjjR0a/ln+zgi
	ujafBra12qWlssr586+bPmaobntfilezs637S+mNORkdpsCb44asC+Qqs+sCDAYHe0jdrswHRVU
	NrBIA==
X-Received: by 2002:a05:622a:1b0f:b0:517:6b57:8164 with SMTP id d75a77b69052e-529d70eabf0mr6863181cf.55.1785216346205;
        Mon, 27 Jul 2026 22:25:46 -0700 (PDT)
Received: from zhangbo56-PC.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a298988fsm66434241cf.18.2026.07.27.22.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 22:25:45 -0700 (PDT)
From: Bo Zhang <zhangbo0325@gmail.com>
X-Google-Original-From: Bo Zhang <zhangbo56@xiaomi.com>
To: fmayle@google.com
Cc: jack@suse.cz,
	akpm@linux-foundation.org,
	david@kernel.org,
	kaleshsingh@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	surenb@google.com,
	willy@infradead.org,
	baohua@kernel.org,
	Bo Zhang <zhangbo56@xiaomi.com>
Subject: Re: [linux-next:master] [mm] 7b32f64bc5: pts.svt-av1.Preset13.Bosphorus4K.frames_per_second 45.8% regression
Date: Tue, 28 Jul 2026 13:25:26 +0800
Message-Id: <20260728052526.3743086-1-zhangbo56@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHCxdc64d-6qNBwwSZX8mdz4-V+88No2x0wG4mex5WPXBDE9AA@mail.gmail.com>
References: <CAHCxdc64d-6qNBwwSZX8mdz4-V+88No2x0wG4mex5WPXBDE9AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Jul 23, 2026 at 01:34:38PM -0700, Frederick Mayle wrote:
> I maybe missing something subtle, but, I think you've changed it from "don't
> read beyond the VMA" to "if there is a chance we could read beyond the VMA,
> don't read beyond the VMA", which seems like a more complex expression of the
> same behavior.

Hi Frederick,

I looked into the SVT-AV1 benchmark that triggered this regression and
found why unconditional _max_index causes the 870% major fault increase.

SVT-AV1 uses per-frame mmap on Linux to read its input video file.
From Source/App/EncApp/EbAppProcessCmd.c:

  void read_input_frames(EbConfig *config, ...) {
      if (config->mmap.enable) {
          int64_t offset = get_mmap_offset(config, read_size);
          input_ptr->luma = svt_mmap(&config->mmap, offset, luma_read_size);
          offset += luma_read_size;
          input_ptr->cb = svt_mmap(&config->mmap, offset, chroma_read_size);
          offset += chroma_read_size;
          input_ptr->cr = svt_mmap(&config->mmap, offset, chroma_read_size);
      }
      ...
      svt_av1_enc_send_picture(component_handle, header_ptr);
      if (config->mmap.enable)
          release_memory_mapped_file(config, is_16bit, header_ptr);  /* munmap */
  }

Where svt_mmap() is:

  void *svt_mmap(MemMapFile *h, int64_t offset, int64_t size) {
      uint8_t *base = mmap(NULL, size, PROT_READ, MAP_PRIVATE, h->fd, offset);
      return base + align;
  }

So for Bosphorus 4K (3840x2160 YUV420 8bit), each frame creates 3
separate mmap regions on the SAME file, the layout is:

  Frame N:   [luma 8MB][cb 2MB][cr 2MB]  (file offsets contiguous)
  Frame N+1: [luma 8MB][cb 2MB][cr 2MB]  (immediately follows)

In page counts (ra_pages=32 assumed):
  luma VMA:   ~2025 pages
  chroma VMA: ~506 pages each

These become 3 independent VMAs per frame, but all map contiguous
regions of the same file. The encoder accesses each sequentially,
then munmaps before processing the next frame.

Here is the problem with unconditional _max_index:

  1. Encoder accesses luma VMA sequentially, readahead ramps up.
     Last async readahead window: ra->start=1993, ra->size=32.

  2. Fault at page ~1993 hits PG_readahead, triggers async readahead:
       ra->start += ra->size;  Then ra->start = 2025

  3. In page_cache_ra_order():
       limit = min(file_end, _max_index); so limit = 2024
       while (index <= limit) ...  so 2025 > 2024, reads NOTHING

  4. Pages 2025+ (which are the cb plane data) are never prefetched.
     When encoder accesses the cb mmap, it takes a major fault.

  5. Same thing happens at cb->cr boundary, and at frame N->N+1.
     Result: 3 major faults per frame × 120 frames = hundreds of
     extra major faults, explaining the 870% increase.

Without _max_index (original kernel):
  At step 2, readahead proceeds past page 2025, prefetching the cb
  data into page cache. When the cb mmap is created and accessed,
  the pages are already cached, so minor fault happens only.

With my conditional patch:
  At step 2, vmf->pgoff=1993, vma_pages_left = 2025-1993 = 32.
  The condition "32 < 32" is false, so _max_index stays ULONG_MAX.
  Readahead proceeds normally, prefetching cb data.

  Only when vma_pages_left < ra_pages (for example, the last few pages
  of the VMA), we will set the limit, at that point the readahead window
  has already pushed useful data into the page cache.

For workloads that mmap sequential regions of the same file (SVT-AV1
frames, ELF segment loading, mprotect-split VMAs), the data beyond the
VMA boundary is useful and will be accessed soon via a different mapping.
Blocking readahead at the VMA boundary in these cases hurts performance.

The conditional check preserves the benefit of VMA-bounded readahead
(avoiding useless prefetch for small partial mappings) while allowing
cross-VMA prefetch when the access is clearly sequential and far from
the VMA end.

Thanks to Oliver for reporting this regression and providing the test
case details, looking into the actual SVT-AV1 code made the mechanism
much clearer.

Bo
