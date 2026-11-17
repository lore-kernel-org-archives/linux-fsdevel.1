Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794916343;
	b=MsJxGzdp6NqKaMg1pHWLypWzjgBO99d7gMMzo7xb6mi8Nb3cMAgxHi+pPnAh3x/Xh+5e
	 GcP2C8bmhCDp9UPFuexdaUSvk7RZR6MUsNEZgcysiLoglDNB2y0K5QbaSj9sBt5Eje7RX
	 wlCctCSBhna/WKAya5MIn6FBuqHX5GWrLU5CRqaNvGz+o+8i/hT3XW3nAIvGh7k+7t+q3
	 lAEbp2fZjaTn+twkwJuLv/qhHXKKjZvIckSxO6CASj5T9N9brhKKucyyun3ERx6gORAHX
	 KHMvXauNupxRTVTtm2ggPTeaMuJjCnJbxAiJmQxX8J0DZ49cxwmM8TG8H+btS1Whx7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0r/m1mAfbKgiD7yOB9oy7sj80T9BKokzsNI3WwDEi/8=;
	b=3bcpZuYNBM5jXBqgeYLa6RYgf32YixI2oYc6ybDlTLlCm2H/rNtoDx8FZkU5OWUjK7J4
	 l9aXqr489OVro9wb7y6FdjksoltQ6VBJhoslDKmTayfRj5BVktQOLsC4eEAcJFOdHshA6
	 PoD7IvljgFroinKU667SYTK1TktaAjAzylSREz38FVYv95z8XJgVl6sVKq3QRWZd8g0D5
	 61lRipO0iayglP9cH/VVOrqXTt+JXLHWZRlcQu1n3AnVfvhGFLheywm5JRvWWsHcjU09O
	 1NGHaptyjouWrm3tKFnW31hRxJGKmRHs697V3ySDs7lampcLJTiAPOPLb5Y/oAb/efw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JM/ndeT6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C1A606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 11:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49C1A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JM/ndeT6
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9d7791b00so45438055ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 03:52:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794916342; cv=none;
        d=google.com; s=arc-20260327;
        b=O1aNwR6kCO9EH/SG/Pgd3R+ttj/z3knVBHs43aSBVWvX0/ebFk127EO22zJqN/WGit
         oQs0Cv0pvK0WROlVdCZnlmKio3yf4oLkNVonUnKPV7TAOuNgcQRfRO2SrJeGx9R9zzMw
         xQzYVQNhWGeu4CmtZUv9w/zZ6mHyLXpVs9OJsxqQO2Ws1wzH5ehECOHrkUILfodW3bso
         1BYQTb3Gl/pvxhTMIAZnEMwGuJVlpnnWpUqKALxU/GBsFvMGbpLiK3DN7t9htrwTaIAx
         H+oFTrifG9m5p+sRYb4JtQev87XSj7XR0HFSoq9vWCJjtsFcWhn392gF/EzT1KhbZuBu
         f9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0r/m1mAfbKgiD7yOB9oy7sj80T9BKokzsNI3WwDEi/8=;
        fh=1cmPnQ6ag9AgP/x2e2m/sfMGSKSS7MDwx7RVEJFuTes=;
        b=U/I18n2QCfNfastzl976Ou7TNaNvT9vnGzWjIb446r5+PAuZqdcC7n1icx0WYxItbF
         tApQrUpBy8FjiQ0UKhvxc0tUw1pLDTBRm0ra5DIwqpzrWRgRDmfovK1AmvFhJ3TrKcIS
         trnL+BYDHtZhmqj0HUQjskhr407O1JUTbnpdZqnJt6HwpazvYmascI8tTDWDzNEYYjre
         pe1rUdgmO7m3iVAxqDsfXCeTLUhh6z2W7t0af1CCP+nvQJShczqkwWmkOeEDq62CIrGe
         YUjKLn8pEYc5KqKHpqR/vNgugZLurEueG9CLwqrsrEKlfQ2MIW4yCCcCrjqDEu8M+aQA
         +ZSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794916342; x=1795521142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0r/m1mAfbKgiD7yOB9oy7sj80T9BKokzsNI3WwDEi/8=;
        b=JM/ndeT6tufj/RSHKfG4OpDX8e7AIeExc1cVqzayA5ozUtzHsxHJt0K+5HaA7+UvRb
         Tmf2c2uv92V4BLS6mm3vWtQs+ol7CzFWT4ILmbVLw/OBylUR7R2HYVxNHsJU6vv1Ez/v
         UOPUNf+PSdMFeMouDMhcRg8T7+kJJ3JdevvTdx2EtxWMt2jkbNtAuIT0umlo2dJ239W3
         6HrTUZpaGXBx7d3HXxjBbYRWaVo5G6mzQU4Aswdspn/dY4tODJvuc/1mye30C3MZS/RS
         +Zxhrb1Uv+OHNp7vw6acsMdlGqoGdXuZJZV3w7/iBTeBTIJKvLt2IPefIqC5SNtjSNAZ
         Zfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794916342; x=1795521142;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0r/m1mAfbKgiD7yOB9oy7sj80T9BKokzsNI3WwDEi/8=;
        b=oY6QHo/OHTPWtSluprtJUxpSIcgTcEweS0Oh69QhVAQGB90NIva3FU2sNchgxTcEEp
         2tj6kLCwC5cDAXkRFljC46M9mlf5ECPPoYsrrUeXc4DCENqpkuY7iBMNul1DCaujZvFQ
         xDRLUrlyFXL0/zfzOjK2DWQxntG+BvmyGy8lMPPkX5pqP2oGGv9UoLZ3Xi9AebjqmCYY
         vRYgL+BbZkQLcrGH+L88KdHPSyua7m3VI4HfgO+vl1WVK0Ima50qxcI4HN80HWG/n5V7
         QIOhKIsTdM/jEVuax2IpucO9bZ2o8jFG9lds7FN5hzYVFJjqsp5YW4M8eLnTokW9v1rP
         K8YQ==
X-Forwarded-Encrypted: i=1; AL+hErG2WrLWazw1ZKd7MlOjTgM9vEqRLe3b55qRwbM2RZuDrLJg5mLv0fkOE+8hSGOUhYHfCXZXUHeuy70XLoDq@vger.kernel.org
X-Gm-Message-State: APuU4Z9D3OZYatvfQlGeTTaj3QsGmPd3ROX27+xTwDY/98P41lbC5shX
	+ckm541v5bUENFuG3ffvUyrACihDOVS9MpknE+bjxEIecBa2gFVIsaiWh3LMqFmdyLcziIWqvwA
	z0MKSBO1mLc2kc4Zr4zGF2hFTHqHASwU=
X-Gm-Gg: AZFdTZe3Q2l+sZxUFcKbrD8Zci+sgRlC+rh4OIuq4uyMyNIKDpMcATkfre3CXKeIiaf
	HtwBtihyXCPcU10EbhmS9hWn7X7shRwSTS0V2gpEt9qX9H67rr3zHzJ2UoNW3asr336T2dlrACG
	a3izyghPE18G9Ywb+yJID8/Itaufxrx40/6nvngUtj4FFsoO5ew73ZTUBMnz6iOX6Q8Ece+/ZWC
	2DmICOW4zjnmiolbSJtyXEIl2LeUsiJ1zrm9Ulq2BGHpA7b1wg1vxkGa9FeJvy3ix0o383uFZXA
	Lm1v4YXhsXzmEN1qrpu3jqZhzcY6jQq29hwOKe1wZ1reOTwca9FNMeANTbnSuzqEEOfDBK+D7ly
	kcyDWCoGikjixxPnLL0vcKCe+5QKYxcyF6Bv6E4MXfhu6QKFjbXcbn/YXRVSXhcV3bg==
X-Received: by 2002:a17:903:4b28:b0:2ef:da34:7575 with SMTP id
 d9443c01a7336-2efda3478f8mr25625925ad.69.1794916342499; Tue, 17 Nov 2026
 03:52:22 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112140101.647-1-adrianhuang0701@gmail.com> <avsQKLgi9bqD51W8@gremlin>
In-Reply-To: <avsQKLgi9bqD51W8@gremlin>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Tue, 17 Nov 2026 19:52:11 +0800
X-Gm-Features: AclHuK_YP7jGU0mfHFtcV45lYkePktMNfOxs8gWCYOKlclcpX8iMtc-uS_KjPxk
Message-ID: <CAHKZfL2UmshKugf9uPBHK2xZnNNifRfXdT686-cj3SvN0PzkTg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 1/1] fs/proc/task_mmu: advance seq_file
 position on interrupted VMA lookup
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ahuang12@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 10:37=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Thu, Nov 12, 2026 at 10:01:01PM +0800, Adrian Huang (Lenovo) wrote:
> > Commit 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under
> > per-vma lock") introduced the possibility of returning -EINTR
> > from proc_get_vma() when the VMA lookup is interrupted.
> >
> > When this happens in m_next(), proc_get_vma() returns an error
> > pointer without updating the position index. Consequently,
> > seq_read_iter() reports:
> >
> >   seq_file: buggy .next function m_next did not update position index
>
> What does seq_read_iter() 'reporting' something mean? It feels like you'r=
e
> trying to make this into something bigger than it is.
>
> What you mean to say is a rate-limited pr_info() output occurs, and when =
a
> process that _has received a fatal signal_ (!!) somehow continues long
> enough to try to output more data, you get an pr_info().
>
> The relevant code from seq_read_iter():
>
>                 if (pos =3D=3D m->index) {
>                         pr_info_ratelimited("buggy .next function %ps did=
 not update position index\n",
>                                             m->op->next);
>                         m->index++;
>                 }
>
> Anyway you should mention the fatal signal requirement clearly.
>
> >
> > The above buggy message is reproduced by the following command:
> >
> >   # stress-ng --vma 0 -t 60
>
> OK I could reproduce the output locally. It seems that this run results i=
n
> fatal signals being sent to the processes triggering this output.
>
> > Update the position index when VMA lookup fails, as required by
> > the seq_file interface. Also save the original position in
> > priv->last_pos so that subsequent iteration can restart from
> > the correct address without skipping or repeating a VMA.
>
> We don't really care about skipping or repeating a VMA for a process that=
's
> about to die :)
>
> We may as well do this but better to just hoist that to share code.
>
> >
> > Fixes: 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under per-vm=
a lock")
>
> This isn't really a bug, it's really cosmetic to be honest. So not sure i=
f
> we need a cc: stable hmm.
>
> > Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
>
> See attached suggested patch that makes the comment sane + hoists the sha=
red
> bit (dropping a silly existing comment).

Your suggested patch is better. I verified it on my side and it works
as expected. Thanks.

-- Adrian
