Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794539862;
	b=b3C4RHvPyd3B4TcVLUJwh9EYURTC/cqPvaMeU/7dyahaK5DwRIp5XjgdRcuEZyMW3Y/4
	 mcst3+fm5vVew9h3L8BgRKuknSpjZrUdYsWGxqmHD0yW7pMYpp6QYNH/6QcrJ8Ge5CJyv
	 vfdotq+gpldXcA9r18ajygWoX9FN+6CY7HLyHTPO3sqFXHYKT9Mr+MJ4RtyEyvrLm+r8X
	 P2voTp9DmBsWzE5xIB4ysQcIboDAwWQO4pO+cfd3h5HSNOptCWYBsculzYCXzGRLB+XSc
	 eJ4RMtVOZzr+dKL9iUO/C5r3Tau04rydSW5QNEGchLPJf2dNVFKW40cgnoxSdMEWeTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n5967ZDHxZDdRDcuY4ilKzGF/DOGAuv3g8MurJqoARQ=;
	b=Gzq2t3LfEfSTG6eAe03gcjYyRrT6OswzumZitl+6e8wDMcFcVkTT4cRhxDXM5+zgRE/9
	 CnH+o198NeUS0lOv5mo1PnJrZBtEmVYSZfZnf+VakZ7JVUcqb0uhRynGVktjnWbMWfYQP
	 H7+tqYfgYOInbydtXvYxKa45+7Ul0Uj0NcqlootKLSdRpJjkFR8w7jY/NK3/3CoeIzjmF
	 I19uiy191smCCR68QF91QWjET92ibN+uVIG74h217WBlUk7rcPYGZ++MJ2IjmTOs9+jpU
	 hF4wQd0h4mg7mQk5/BOglQatDXSSDnsxOJe5da5G8LU4tGTXAFFkXq41om7J4zvC4rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kacws6zS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E99606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 03:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E99606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kacws6zS
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5383c97c8cfso105931cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 19:17:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794539861; cv=none;
        d=google.com; s=arc-20260327;
        b=MnmGVdVQhyKM1hNBLDPjbxdxHPcfnVO6CIdiEzQif6rMZROCQ5J3E7EI0XpdTEnPUe
         Ou4trDya7EpYUGCJIt2Fz5Xm/An7aH88vKGFMPti1NGrJdxkfFXL5/Jo1dAZgv+1Ux5X
         G2QT7HHJ1BVpeKHWXU6xyTa/0Elo7TrpLryGtFGfdcgZKiUBw4n6oEIyMeOVSNFJX2Lm
         vqpIGVBSHkcWEvcnO+p+mU2ar5Ko/C+f05CbyLf92mNXX6c9UCgaxZnVQyXX2psIJCCL
         Fm8UGnAbN/MHzlaEaRsMGkxfeIpao1kg7gn1Xtne36Qz1EEKlXBYankNwkEVwl0hBC1Q
         ghmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n5967ZDHxZDdRDcuY4ilKzGF/DOGAuv3g8MurJqoARQ=;
        fh=DJ0+mT2/SjbHxHmG9JDIeTAsk2RHBHPfMmQLP3Z4y4c=;
        b=JXKaQ/scDhPfGsF/Sr4sORyrhq0SSmeHBBq5HVay64rKD1Ci3qLlLKfoBUS+8wrcp9
         Nj9Stbsh/vis+ZbYTi36+9Bstt1nquoIHYp1Xi8uA6TYKtcWmxFWf5ekHX2GnkWkmEGV
         t1GgGAhMZasfULveud5lIcHA4LEhj7kL8gBC8hnrKhAHPiZlTJksCxM3ewohQQbmWojO
         sOvI60WIBNRhqI32HbBylMSjv/9mPzJbyZAD/CJ6S9NX6tw033E9FQ+DoZVJC5M0dz5K
         WYONqgfaAjWwqUqCytfa8YN4bif+SFNS9WA+aAgNYTWcfFzlCgXFQw7Kjh9BSdVi+V/l
         LXBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794539861; x=1795144661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n5967ZDHxZDdRDcuY4ilKzGF/DOGAuv3g8MurJqoARQ=;
        b=kacws6zS3CUOml5rgSdg5Iy/JIAu/IqgMh0TTw942+GgstlfOTYQXqmSOCcYRIMSSs
         By37LIJToULz2MSya5/aju0y8rtGK2ylVUzOQgiyxfP1rMNobgbhfSXe5BG4AE6y4ok+
         HtZMOySBK2CHpmTv+iJpW2X7KjG37HpTgrTpoelkd+r1T0TYDiPJRf+kdYeofRq/M4FS
         8Jfx+LTfeScilR+uMOTQfcnqe3srE5WbfnGY9NhHEXslham6nsM31YJIBGUPVQFgCKJ3
         xpIK0MyTqMkJVVcMKx/Os123vHcDqnBXFSZKxQCWt/ZkTAejO1AwDMUwWSKHeWvWiMWb
         ePEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794539861; x=1795144661;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5967ZDHxZDdRDcuY4ilKzGF/DOGAuv3g8MurJqoARQ=;
        b=CxJpBHb/MR1xEOeUkMINJq5KMs83uwEBvM3xq6vPmpvgwNIUzWsOHyPiq/TCUFFkQ+
         Lyi5lH1GrwJYrEa0+GK8eB34msXFuXxyFoG0PquGLWv2ZdSCjgc3wc3cDxjlgfLpPV70
         VzRPLDsDfCptcZU1aJPVLFJ3zoYUbIYJy/7Ta+VbQFoKfUXbrAkJ7NlJ3VtgPzmvbNUB
         U0ydldmjrDQnYkrxMfdWyrc3jaAcKNUYMa78Gtyajf+yMhb6Q8MtG+DwjlEQc1S0wAe8
         w9YBVgkBth+m9kPruTOeCbQOGj+wLgim0Zj+sbud2GcO+EnSOzt5o1oquhipz0qPbC1R
         mzig==
X-Forwarded-Encrypted: i=1; AL+hErFC9C787zSAOkPYlUEETITwgRjUuZxAfB7Vvjbyp9KTtYYbsfOaCYW5a9IHm9yPcDxmCXxjNFAHzaD3CWIm@vger.kernel.org
X-Gm-Message-State: APuU4Z/K0ixbA1r0EhgPu3yS/jrCDmC/RtP4B5IahADXIJn2NDk8O4/J
	jFiPW99Ps182OTFSHs3DjQngIGTtwhhS368L1SjsXdUZUhua2rSLi0hhFkWplTtJXry8V5v2L3v
	2hPn7tCqL4ctLJo0Xu+VbwtFOuXKIHnvm0cv3+rH0
X-Gm-Gg: AYBFou0Ts7EW9MA2B6+jzrvf2vt8aLunWEzLZbUbKgdNaqoi3wQ1MPK8o2yP6dy1lHn
	9FvqMf5wFoWY7jSpXTdjUW+fJt8c2DMK2dfvmq6XfNaBxSQ9gmGmUczN8zyH5X5je0TymDF4tSp
	2iaF2M3Zc+f7LZsCly4ZHZBBbDxygxpRr16ADMjuq2enKV7G6seW5+1N49WwcU1Gac6i0u9/svs
	ojemSEU6rrBJJvXIJrXidCSYvfH7xIwk3gs82ztVl1ZvWTOCpK5006ZGmaGebtalrktcx0D46XM
	o4MQvdgsapGmDRzcUvVXxLIDwqLUL8QjOKIbkDC+JuLIBHFf0i/Er9XYQUpHgUz2z5liofHp+Zw
	712/aBHEGTmgaLO2TEAT/+26xZhy26EdHFWi08dCtDqkvrpVhAFGWec2fIajlzHIF30HwiBx8sl
	vojDSTt2BTGtxGOCjE
X-Received: by 2002:a05:622a:408d:b0:530:e335:4ef with SMTP id
 d75a77b69052e-55ad7e74d7dmr3502411cf.2.1794539860114; Thu, 12 Nov 2026
 19:17:40 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112140101.647-1-adrianhuang0701@gmail.com>
 <20261112183727.68afda9533aff699eea12cdd@linux-foundation.org> <CAJuCfpEqQQb1_UkWH50tgbdVz9KZ2anfCGWsvvoYFsnC_KHcjg@mail.gmail.com>
In-Reply-To: <CAJuCfpEqQQb1_UkWH50tgbdVz9KZ2anfCGWsvvoYFsnC_KHcjg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Nov 2026 19:17:26 -0800
X-Gm-Features: AclHuK_2-9zUyKpx_ep8Hdpnolqj806Xeb68SWZdKXrDA-5ZStmcnD2-HIkJzN0
Message-ID: <CAJuCfpH57DNEb5ckB_c4QTWiiHVGSHNhB=S6HFdjvJ6GgGNSnw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 1/1] fs/proc/task_mmu: advance seq_file
 position on interrupted VMA lookup
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ahuang12@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 7:13=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Nov 12, 2026 at 6:37=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Thu, 12 Nov 2026 22:01:01 +0800 "Adrian Huang (Lenovo)" <adrianhuang=
0701@gmail.com> wrote:
> >
> > > Commit 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under
> > > per-vma lock") introduced the possibility of returning -EINTR
> > > from proc_get_vma() when the VMA lookup is interrupted.
> >
> > OK, but what's causing the interruption?
> >
> > > When this happens in m_next(), proc_get_vma() returns an error
> > > pointer without updating the position index. Consequently,
> > > seq_read_iter() reports:
> > >
> > >   seq_file: buggy .next function m_next did not update position index
> > >
> > > The above buggy message is reproduced by the following command:
> > >
> > >   # stress-ng --vma 0 -t 60
> >
> > afaict "stress-ng -t" can send SIGALRM, but mmap_read_lock_killable()
> > only responds to fatal signals.
> >
> > So please clarify: exactly what is causing this to happen?
>
> Also I don't think stress-ng --vma 0 -t 60 command reads maps, smaps
> or smaps_rollup files by itself but I might be mistaken. It would be
> nice to get more details on how this gets reproduced.

Just after sending this I found
https://github.com/ColinIanKing/stress-ng/blob/master/stress-vma.c#L536,
so I stand corrected. Still, it would be nice to know how exactly this
issue is reproduced.

>
> >
> >
