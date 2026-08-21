Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D47929E0E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787275407; cv=pass; b=tDpkQ5tqQc/5zSDweOekE0qpV9mR/dLzBD1ekKVuAEwv25bvj0RnoTqsVGKYrHsPyOl7kXmhxhZF8AWvmESoUG3QDNyk1qJsRfsrsOD/+nqoqNREYl+4Z1SPm2HB+z5urMdeOg0ZnHWwHIz64QIt9LAWoaMcefS0DGV3ipsjfcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787275407; c=relaxed/simple;
	bh=xycC5ms9bEdTdFwHXSndrPsDW9s5MrKRjpWcmUkwb6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXVQr+YhOwUKBZQgaQ3Ak982F6GZCtPto1m4RLO7EX8qYwGc+Tq8riNNtSIprCEHa+pHQLyLwHDhVSfdmwMkrBoND7Lj0pz+v2l8HXXc0URx+/MSYBaUyOD4D3FDTMdRrAX95cFh/lEReXc6KZi+ezyO0l/uJ/cHCg+ZcRcBkIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7Ys3h/D; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7Ys3h/D"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so500377e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 18:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787275404; cv=none;
        d=google.com; s=arc-20260327;
        b=IFQLoO4N/F1LgQ5fIi8ilSG834uPUF2BjUtl2DDLqYOEzFbQMNeY1oDXgZQ/9b+TQi
         zkrDMnHIGeDErzB9flYjRXuapUcFjmMrwrhw5jTYpEIddOFIXiO+HoTNudqGPk+2MgeD
         LAg2D8Ca4k6nhML/bVuV13tgV5WdMiukM4+jgtZie6hzDMB136KCPp8+XGBeAR7IGFjx
         J9etsXyx1QamxUOiiEBXsPW0Cbi8jCfG5HrH/wIQdgwCrCoxPQFAyVYdNzPjSveGjPBN
         aFCfK2h818jMYmSBjG31Cr44NIPHaddK69/6yiiaLmdExYApqNpwcGS4/BNS3fxcIdLy
         ioyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pWsWssuXjwjvPhFQvlbrp337HR9wzl0754C7O4zlVnE=;
        fh=6hAkHrbXBaNeWFBC8SCTOnb/QkzN3ig6A2qhImFU4rQ=;
        b=V/RhRiEtQwhGzaIfEAj6JX2unSaay5b0TUOKwxPAXMSoGORDXeV7bdVuCrfktdQ12U
         0pu+ZZwvIH92HPhFgbtoX17LKS7zuzflQCmZAwlj/VmvGIsVVb5s5qGZvsorR9aQcBeo
         LoOto+amATa2iTa28RDCQepFPKOfA6+9RN9Gz/O41AwZtwDqRzcggircAd3tilZkaXld
         CviA4Ja6z4S8lVIczcbS0ugAVMbEwx539SZNeRFRnxEjcEklE+ThRflQ83UvZnc6XySC
         EwYc73UKv9foqtlS3Dn+1nZuAqdzgWqAPAwTf5MYyMjpF6+jVYRIF3+ZBfsBMvGWPTdY
         z+Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787275404; x=1787880204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pWsWssuXjwjvPhFQvlbrp337HR9wzl0754C7O4zlVnE=;
        b=R7Ys3h/DVePMRhcE/YHLjPmdDGhJ9wfPNDZ84dtqhd6Bft5dthrZ5MiNy+wdnROmrW
         A46+HEaq33733WtoHyvhiuq5E7gJwW57NeA33ndFGXE5nz+gGkhQw29vIRUbw5ifXo9b
         NEdnt1B+5bsshPMDG9y7f8GYjMCvOp56/vzXO6ptOVFYf9J3WMvEa40SnMpP1Y4a33mY
         Bcunt1g+RuJV3fTFFqhwk4yZnTN71v04IxU5QxOkTEMrm+1wcHJAVs3C5tu/TpCqE7Jb
         fxIVfro5yvK2qAG/gN4jXAzMRZaxLZiQg9QS7/kumwkGZmQ5XeVDgRqSsrc+4I417UtC
         HucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787275404; x=1787880204;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pWsWssuXjwjvPhFQvlbrp337HR9wzl0754C7O4zlVnE=;
        b=jaf7plChPshWZyw2txzAvc2e/ahpugpXlkxxq50tBxywPsju5pC38VF0munXfa+X8d
         gqhIYcyX9lW1q4o9UlXcl2m9bN0VWQ2rqJTMHdFF5ND8nvlS1BBPddgZE0lScL3dkKrS
         Hb6V46X41SwNsRKcgnhZRD6vVjBI/MGe0G9bjdTMutbh5oOTXNQzIe6KKgmoiVR4tGBz
         nBg595Zn6Ch+/7ZQKMUD2W+30QHkgFkpmUzEXYnoKZGLbI2yWYFwkLjqOxyDXVVb6buR
         drLfoREBd0EfoCozphUGB3q7/wcUnyR2j4MthsUiUFfeek7si1wspreCzf43ucsW2goT
         0wuw==
X-Forwarded-Encrypted: i=1; AHgh+Rple+51lzRsX4uYxJeyOd3hXUijh1zppIXUlcnI4KQYIcwAihlOQ1du89agAClrsuA/xdpuqBRP70N1IgD8@vger.kernel.org
X-Gm-Message-State: AFuF++kx4B4I57Lh4NJVDsK6+uKotekR53vu5vUTX5/DX3zPYab1Nabt
	dEsMlFaopdcMuHLjpRJts+xA48WQp9pjk8FQpQ1Vw/TZlYTKoosyrQbE2yivpb0+K3oxoOTBTH1
	d7kS79VCtwsgoEaVdvZwI1Yg2r3iFoJk=
X-Gm-Gg: AR+sD13qOjWkX01oujg5c8rGJgrWKTgtjjN2OCN8sQuTejPN/tbHrtPoA9q8zHk2rAh
	vUp8pWiFtMloVzxYr7JKPxs4wOWZ1vkMWU4AgzT55AoS40KKP65TFqy5LKWPLn/rPDFLdN8bM8o
	KFVSkKZkCb7LYzTQ7GsOwIV9KnZrpnOi0CuiSeCA8SlvP02O1GCRlitaI6oVrbCdNwYO38UCYsm
	BrfFyQZIKZFFJPth0e8Ed00UbDzUuLev5EH+2zmg/IRAUqLeRI81B0fc7yi+8nU6MmhjGlu9fxW
	gCsXRxxXkH4JGnEzSbi3Ntb4pXqmXWpXuIQFh+RWwjGu5AH19NTERfWnXg==
X-Received: by 2002:ac2:4141:0:b0:5b4:5f6b:d43f with SMTP id
 2adb3069b0e04-5b484224d67mr478198e87.11.1787275404102; Thu, 20 Aug 2026
 18:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com> <aocQcaMMU7-rfn3e@casper.infradead.org>
In-Reply-To: <aocQcaMMU7-rfn3e@casper.infradead.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Fri, 21 Aug 2026 09:23:12 +0800
X-Gm-Features: AcwNN1VJOsgH1LSKLZ_AMXGaWVJhNJ0llxoWGDBcEyWryT43OMevuzPZaGZ4e2s
Message-ID: <CAGFpFsRarmDScAQxHpCtSZxK5H4WCg4Y=y0hXQLjGT804ZoWkw@mail.gmail.com>
Subject: Re: [PATCH] mm: filemap: tighten dropbehind completion context check
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, baohua@kernel.org, 
	Wenjie Qi <qiwenjie@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is based on code examination; I have not reproduced it in
  folio_end_dropbehind().
  There is an analogous EROFS report where bio completion ran under an RCU
  read-side critical section and hit a sleeping-function warning even thoug=
h
  in_atomic() and preempt_count were both zero:

  https://lore.kernel.org/r/20230621220848.3379029-1-dhavale@google.com

  That is not a reproducer for this path, but it shows why task context alo=
ne
  does not establish that sleeping is safe. Here, folio_unmap_invalidate() =
can
  reach unmap_mapping_folio(), which takes mapping->i_mmap_rwsem through
  i_mmap_lock_read(). I noticed the mismatch while comparing this path with
  the stricter bio_in_atomic() check used by the block dropbehind work.

On Thu, Aug 20, 2026 at 10:34=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Aug 20, 2026 at 10:29:56PM +0800, Wenjie Qi wrote:
> > folio_end_dropbehind() uses in_task() to keep folio invalidation out of
> > interrupt context. Task context alone is not sufficient: preemption can
> > still be disabled, or the task can be in a preemptible RCU read-side
> > critical section, while filemap_end_dropbehind() may reach
> > folio_unmap_invalidate() and sleep.
> >
> > Use the established conservative three-part atomic-context test: reject
> > preemptible RCU read-side sections, reject configurations without
> > PREEMPT_COUNT, and otherwise require a preemptible context. Unsafe
> > completions retain the existing best-effort behavior and skip invalidat=
ion.
>
> Have you seen this happen in practice, or is this based on code
> examination?
