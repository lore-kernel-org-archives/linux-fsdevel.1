Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A2B36F8EA
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978566; cv=pass; b=CIaHX+ZXhtEVs8j43f5OoN3sFlM6IT9CEdfY1BG3KXx8achCGWuegPQvhEQhDCnqJZVpr+QsiECUrqD3hs3iND3wBIcldiLtFzI6r7nD5D+xgF9gvqt0qepDtQTFAb2xasYKs+EPEUyR4ieMuNcdIk+oQdGv3JENhTJGBPEwBMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978566; c=relaxed/simple;
	bh=O80U+VoanmQGpDG/i4GPzQW2Nc5FZMWWwqpPOFq4e5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6BpVm/n9ri+q6KRFjyn0b8uplQTOY7CqRwzOCjiy6/9LVr4rzBFFlnNyuuVCNjR+tDM/8x55Q1mcOqifdWwhpG+5CxdsWKB8OpAA2qHDYFADi0dpdJNuGipoUaQKz67OAtjV5tFkzaR0FeNz7oMsbY/aMdMZFTBbsVSBcK0GA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lU96vxhI; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lU96vxhI"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so341071cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 11:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788978564; cv=none;
        d=google.com; s=arc-20260327;
        b=n6g5WqqfI6jwtj/AXlJwJBNkB996cbRq0PcqAbXHSu+mXjCBnmwZ6LdPK0CXVQPCla
         7v1k5NSNAkSBxH8OYn1dmy2+ZFT1zUibAzpNclar7MV2IXywG2peMO76kVdVPUYLJzus
         E/AAM8F4UErSNkIgIyRZi6+pz3FsqY4kwa0cieI7HIOnFY1y06RQkywk7aSEjIlvgRo0
         rBAOa+Dq6K5J0ryyPXqmpupYJexZfy+pqcPk1KOSs6ab2yEloX843soDGf/Dilm9wexW
         4zrLnhu1t3kWVGw2UE8Oh/rIudL2MFRlMXF2y0uf1Dff+K2P1fN1kn/6GMwj1M9Af5kS
         0Ovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O80U+VoanmQGpDG/i4GPzQW2Nc5FZMWWwqpPOFq4e5M=;
        fh=AvqKHY3PzhaszN6Duk49mIMu6Bt4NECg3UNbWEAbOjc=;
        b=UxGgfDy0yRCaTaHg/fpdvgpSjwKD9zQZCs+9RpQjEGyoEtBpJS1hyLuvfVnrE9cV8T
         rjZYfr3zFS0CO8n0QRGExIYC9XTb7ibt1q4dfjWNqF3SA0g1yVDqrox2NSGMiVjfRk5S
         8Inw+QrHOfP8imwq5F5gZZB5V04l4YqmLmi83PEnmmbiotPCmZjgbVAMY/JfSa7sv8ty
         aH+4WwatOEVbUzsAuLg9tHIWC+QZPINNBpSSv52Nqf9h8D8AkCJXSGT+Rf0aVQ0qItPp
         KDpZuzwcSSOjjL16AWPkIIOQk3YkC2dsWzDmRQpQsxDoh7t8kqbWUUqIhNrKDxk1BmJM
         nMTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788978564; x=1789583364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O80U+VoanmQGpDG/i4GPzQW2Nc5FZMWWwqpPOFq4e5M=;
        b=lU96vxhIbvJ9FR1ob5kmNT95aUvqHC3jDDMaXH4T8UPv/ZPI2k6vC5VKhR/GIMlmmI
         C2bObQ9ofC6i0mHtGZH4ResZ4jp8xYkfzqxnNbhiXyuu3AM8kvC3iA4TVhCbF/n1WN8M
         n4CIefXuBEUgbfloOIowmwGdQ5biX1DkqgmmoTyYWWCaMOdCfec0OM6No1sLz3teHDJp
         fZH6H3OONHCd4RMhQ1TnAkVa2woPmDGfMwPBadxi4rwRHL8ZR5CrvSbXUFoiVY1DS+zn
         9Kb8KQ5jPE1fdZncJshzncWOcIN3IFew4HUxhfYCWhYaZ+//gVV2GAgaI8r7RDbdk6qW
         CEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978564; x=1789583364;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O80U+VoanmQGpDG/i4GPzQW2Nc5FZMWWwqpPOFq4e5M=;
        b=Rl3JUVnYXrbFmkNv4sJAXGruFDwJ39KcCGz0hQ0561fIs3lmIXwYmR6hl46YbixcPl
         wSWVRsfDZZ7mh1Fpi1x6oYhNmILQsGPnXlyi/Wb9yyRKHnyxXyBzOe0PuFgzvpgc9TkU
         rRy1P0HjSmf/XqSioiNlG+L/XJH1EFNFHyJaYIUWTd6zJF8dp5x7IvD//Yim1ii4rUCE
         m6gYpiII61Vyu2XFSQLrXPGgY/Joy2xFOKShPsF7a2uT5Gpkc98+9pkePzNYawnnmbHP
         EPm8inWy++5bWt/zLN6bYh+ow+RDp4Ro3vttB1rZcBUFuLatIyaIiXiqSC1dmgjLhoaX
         NlDw==
X-Forwarded-Encrypted: i=1; AKwUvBy7261LmLrTP6RwC1AAj2KwLGwxM67QDkCg126KhHFtM9f6TSxC3UxPw+Uwcusl0J+6ZC+0Wx4MzEDaH6Sv@vger.kernel.org
X-Gm-Message-State: AFuF++kHmyhXCRVbo1hu2fvsWBwJAb0YerOl6/8VGwkjeUjVxfsKeHH9
	yhDLXfYTAeXkBWaSM0btoXHVw2R/kaS1kPMw1jVIQsirfIIZ6bvWeBpBwxUJ0ijarkI3pj74dMB
	WupL510atME4AKgvcozZ6RO0uAx9EqxsNIm9Fm+ef
X-Gm-Gg: AYBFou39dMMilF3m9cezDvlSYx6uS1wnZckXOF/YsRPWvQq+3uNvfc6tmk0vWw9kPRT
	iNCGGvSa/okrJ2/rHlsRYmoCM3icnczLIHpvgJxQDPIZv46qRS/aOhB6e8UyNtR+xJIhHH3cJ2d
	oKMjKEAoVZh8e4AUoTJlg/b5Q969PlU03O80uKqYKD2RNLhMpYuro42dzcwwymJ+Yw+IvTX+YIR
	MHjF10rASNbcKA++hmryLgMN71Ox48sml2zjrhdz2uakkJEfphaye8JRPWlIH3lkVpE6nHjLKA8
	iIbTRCMPpGbv0togy1TvHFE31WpjDz4rK3VzmYs+hV7g+07ect3FhGX/LQ==
X-Received: by 2002:a05:622a:250d:b0:52b:4ec6:52ba with SMTP id
 d75a77b69052e-530b48fd11fmr591111cf.6.1788978563357; Wed, 09 Sep 2026
 11:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com> <20260907063918.3432401-2-surenb@google.com>
 <1d5011f8-26a1-41e1-bb9d-8d72c08b8fe9@kernel.org> <CAJuCfpH25ML1+hdhTtZUoSjgrNcGv9HbQD8o5UErmAdW-7C8Bg@mail.gmail.com>
 <855cb221-cd57-4226-9c98-6a66454d3e62@kernel.org>
In-Reply-To: <855cb221-cd57-4226-9c98-6a66454d3e62@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Sep 2026 11:29:12 -0700
X-Gm-Features: AcwNN1VQzVaIrt4CsqSl4wbBcmo6cgneSWi70hN4qsyBG-j4NAiE3BNAF6eDoQo
Message-ID: <CAJuCfpGFYjs7pAstoRhPOWFbi5PdiX10mqBzOBpuJ8qQN_zsQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] proc/task_mmu: remove unnecessary helpers
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 10:17=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/9/26 19:13, Suren Baghdasaryan wrote:
> > On Wed, Sep 9, 2026 at 10:06=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 9/7/26 08:39, Suren Baghdasaryan wrote:
> >>> When per-vma locks were behind a config option, a number of helper
> >>> functions were needed to simplify the locking code. Now that these
> >>> locks are universally available, we can do a little cleanup.
> >>> Remove lock_vma_range(), unlock_vma_range(), query_vma_setup(),
> >>> query_vma_teardown() helpers.
> >>>
> >>> No functional change intended.
> >>>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> ---
> >>
> >> As Usama says, this could get picked up early independent of the rest =
(maybe
> >> even as part of the other patch set)
> >
> > I can post the 3 cleanup patches separately from the one that switches
> > to using per-VMA locks if that's preferable. One downside: I'll have
> > to wait until the cleanups are picked up before posting the last
> > patch, as it depends on these cleanups. Please let me know if I should
> > split them anyway; otherwise, will keep v3 as a single patchset.
>
> Let's keep it as is. We can reconsider if we realize that the other patch=
es get
> stuck.

Ack. Thanks!

>
> --
> Cheers,
>
> David
