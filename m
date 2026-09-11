Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08D48640E
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162309; cv=pass; b=GdMVImXqQUivJwkoDffBN1+LLVgoR6mEy+Qh3oib55AhST3LS0ogANbXupN8gtWltfxumavrbPh7IxrF2Y5pk9+eS2kf9jLW9Cznq3BGitG4SXbSZ3quxhGLdczEKvVkDx5VhAUF9gOSsO+ySQDUQczKuIU9/e8oFBCxwrYzIaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162309; c=relaxed/simple;
	bh=VGvIJQkp5IyRlQ+7Y8L/xW8OHuy5Tn+hF4zSv+pVlvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTm/6OS+Yj2TYgi9FoRCmkMZLokCmmeogkNGYRf4Rdw6zJkXhdIIpAFI4EKa26sD7i7c7hBOM9AYDH0jlIoWYOnOVIPu1YRfIRcVHlpfln4atp+FzuV58iU1/9kgZFLkXeYzslIrty/6+xckhyVQ3o+WmlyG2VrvwWnc+1clFXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z9u33UOf; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9u33UOf"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so159091cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 14:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789162307; cv=none;
        d=google.com; s=arc-20260327;
        b=kS1Qj2Gof7VCIFuQnhpIr9Dhwq5DqxpCgfzJO+Irr1rka0NMXVUh7EBpSOgc5FkddS
         OPZifeEBx+wB+55oDNBbW5RXEwiIToKSMBrwV3bflcNJKjDMG9Q/fTFpmu4bIF0pxk8h
         F8a263ZaKTSKwD4Vzz5vLXdPd/v4qYfBfxJphUK49Y4LcOghbUFidipdHHGGlnJqBnzM
         DTL8JypnzMtP0a2Nok8ZCCAizVJpylmKnPNB5mWDQigwJ8KxldsnqeIqGE2P8OBHng7n
         /D4dByCHb209tZpMpE3Sm8xMr2TKdZoiD7gpcruHYKvIJ9z7Xvv1uYWki90yErkm0XW9
         e88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VGvIJQkp5IyRlQ+7Y8L/xW8OHuy5Tn+hF4zSv+pVlvM=;
        fh=6axJ/0R4auMiXUGpw0cNJpDHhqCwIGvbPH4jXWXT5c0=;
        b=nU/zOw4sNNpbjHaqeUrmJRcKHXb/8t3ud1pFQTAAEUUrMq/hFXlsOVNrSgvqKaglWa
         yB4aSujs3kyBO37X9DS+JtSyFhdz7Dvn/g9kPgo+ILSROR/WU6VykXJs1zMBAYUwVr5N
         SWXu10/VfGFiYEpw3kqN/UVK/ZBVO29IwCy6+UZp2yG3YK3YHAKQHHid9Ieh4vZicgfi
         6qwXUyW/wLdc80pBK5oEenC1CzH7q3qSs92/ncnCQUQdO0yiWCJ3SQ3MGRbJ3kOXAr81
         reuPL2wlKUdqwPRWm7G4bCp2yeLXib6ywxUfMZbDAwDe9PXVCv+iy+c6+M3cST2tvyg+
         BnAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789162307; x=1789767107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VGvIJQkp5IyRlQ+7Y8L/xW8OHuy5Tn+hF4zSv+pVlvM=;
        b=Z9u33UOfoiTT/qg/fUgnmE+5V7bR/lua75IJMTY0NekWoODd3ccYqB5Dgxud/2T7JQ
         6zc4ZRtE15PNMFjE+C1s+ugS37YU/EHlEFhzQ1XiC2LzxP6E+6PGqReYahW5X54VDIof
         81YTq1XjFKrTpnDhzD8RlUQ/f33B8Scop5cLJwkhGnLG3XuTap8C+66J2tYFYaEWxxLu
         /fCuRtJ0mbmTIJ8cOSBDpWmd/iI21/kgGFoenLg0gpsFpnJehD+TWr+ae03z5yfACYMH
         GdS/LrSP2f/k6lnhjYbGeeSASljG+rwmdq2CGKCPqqgfkEjW+HDevzX++wGSVubVDHYq
         BdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789162307; x=1789767107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VGvIJQkp5IyRlQ+7Y8L/xW8OHuy5Tn+hF4zSv+pVlvM=;
        b=LO4q/rAPsL4gVJ2TlOIlJCUdS4DDC12PgLk3/W3XsNRuBZvb80TFV6Fe3HA1cI5etY
         aoJnP5gl+HjLkHk1uU458Zl5kbNaFqfavoamx09JAvmH5lPSw4BueuXeIXj9npErCcim
         F/jDM9i4jLsLQpgd0HD3ofhpxrNhpubyCLgk23aFZdeMBZlyj4cPhecwocI184xi/0bg
         pBhpKiVJpqfHXSJGWKdEEgtdToFVQy7zppP6E+yrbqT/nMVFhqTgnx1n+3JqrYDYsBdg
         3dFK13Zh3Y6VnbdgNYkEKnX27T+obDMZdC5FY2Eu3m/EAyR61+q6N+wpq47Gat1pFWxJ
         nFPQ==
X-Forwarded-Encrypted: i=1; AKwUvByik2nF5g1C/AoopKeozCbSfrtnSnSMP4Q3N7wdWGU3OeGvK1zS22OoQLqWgvoQy1/PbGBgD0Vj8stClY+T@vger.kernel.org
X-Gm-Message-State: AFuF++kBy5h1YpKXTl+shZqoMCYDJVJyjYR1en2hp/LWhssywiNdPWSX
	w7IVs7mNf2gImgrWYJVp0h/i62PNd/YTUTyQ2NbYseG7Ain1DiePfC6NPLPXrSEVURa4+F5XkHK
	S0fOJ496q792NuNhi1+YyyY5FAOczLaQCyYZnsDE+
X-Gm-Gg: AYBFou02HrvTLCfrx2GYl+xUEisYN2DxnqJsX9KcjpmtHVcfiPDUiFJucOtVNsi2YWU
	zOysISsXwJoyX1vZiMkeZIEdWBDUyVt84tvzefBT4Yb39kmID+GN1r92KkUZb0bJgtXCEfxnxXJ
	dN5q7n4oFKXD3xf67lsQPkDk1WPr6GAxVWSthxZIW3DdtdKcmIsDf5Mm0UTwPAdBwJNsEb+6P59
	HrtCxhw4XsJy2HXh0mq4oBWNA4Uk+DOctdtMvJ+KJvIYXrKtQ++Z7J/IiC93QXgrHtOz3NinwK2
	lUpG1S2CE8t/oiwsH6kvhD6L4WLdrvusGOI46Hsk6X9PgeR5NkbCQg==
X-Received: by 2002:a05:622a:11d0:b0:52e:1e8:21f4 with SMTP id
 d75a77b69052e-530e63d3194mr1543051cf.5.1789162306468; Fri, 11 Sep 2026
 14:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911194145.1781926-1-surenb@google.com> <20260911194145.1781926-4-surenb@google.com>
 <8a5abc5a-bfd4-4fc3-aec2-a567ef5c409a@kernel.org>
In-Reply-To: <8a5abc5a-bfd4-4fc3-aec2-a567ef5c409a@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 14:31:33 -0700
X-Gm-Features: AcwNN1UKizZchXvXxtFlTQJTapR2k2sJ1U1PVMre-GTpxn3kamF7rTTUDJ1EgCI
Message-ID: <CAJuCfpEp8eBidJSr0NZ-sBuJh-d51BNuM0SJAOSGN7m7GjY=3g@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] proc/task_mmu: clarify shmem mapping walk
 conditions in smap_gather_stats()
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 2:00=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/11/26 21:41, Suren Baghdasaryan wrote:
> > smap_gather_stats() optimizes stats gathering by skipping the walk for
> > shmem mappings in certain conditions. Update the comment to clarify
> > these conditions and use vma_is_cow_mapping() for CoW identification
> > instead of open-coding it.
> >
> > No functional change intended.
> >
> > Suggested by: David Hildenbrand (Arm) <david@kernel.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

>
> --
> Cheers,
>
> David
