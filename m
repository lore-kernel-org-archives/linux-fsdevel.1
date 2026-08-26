Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E1F313547
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761069; cv=pass; b=TQtk/FwpnCH2t6BNDeBvWwwOoZOZU6DERbtlYdqonJH8/75HHSfifybqSLkFbicwcNe7w7pYPC7x15p2HCXp9lyBYD4jBi3/7q/YMSObMCEbYaF2FGA0g64DcM84tkSGCZ4tIItrhtVaYsYntKxHOcxNKSYIEXQMdHdb5IBCFn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761069; c=relaxed/simple;
	bh=wS8Isqy8j1V26xF5Dw7K3OrDRfOCKejghaID5rQbMsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAjqBncCKCul+1eB0YFNlsQJG5dA+5YkdRBLYJX+hozqo55PmPwhH37BNsIrkzsjtcIIpAqqMX62L1slAlBYHrwxYcEINlH5ICu7HWlfeI2SId1qysxF707AOyxkn2NeeVpjmgPQHueRr05gxxC7gqy9814iL1RhEGQjdw7Z8QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4QhHqXc; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4QhHqXc"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cede6375caso143905ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 09:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787761067; cv=none;
        d=google.com; s=arc-20260327;
        b=T95dZPK/Wgz4634nvvyR3rS+swDGNV1aSVPqdyY+42lv8/CWPj6xF+ZZ5UU9E8lZUY
         q6VYiXDAhqft6r12pUhc/66xXhpIs7BlfgrG3Wa3hmAMJeDhVmk2WEBglsouisgNoQ2J
         NbASOAS7aSADRMu1yeu/XnFVv6hcy2WMglicxkThf3qtyk00O2HQSfBEm5b0lZ3ViqQ0
         gBrUg0Q2546T3f400Q6JEaLTig4sAHEaXZDJKArZJtzH7E7xz10MbYGKCo0zlvwX+Yst
         XH89OCRNaM0Z3sxidHOdvdvn4EELLBRa8RdNArh4VQX0FenhZney4O9S2Sx8VxmJQZlc
         gS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wS8Isqy8j1V26xF5Dw7K3OrDRfOCKejghaID5rQbMsc=;
        fh=Zk2g12dM17P04ejrV8Qz6BePEEIZUmx1LjLeYtvBgkk=;
        b=UG9zHbAD7HF1kvCABGBjzP6w8j5dhyQnwZUwD0Wu00whw2voqJp1ZTh0DI5pAkRmRF
         HENQYiqBRRX2cl1OTMHwG4JbMHzOOoqqH1a9v9OKGIxoWuGLE5wEoW7uKj0p/CjrRMg3
         UI48yacxsKW5HsmCyZCj9jPYSm2qcIbcDyb62QnT+1iAPX+L5/D/m/Qe1WPZEgXFVuMv
         30pDxaS0Mlsq4PBEpdHoI6QvvN6OwRs3z7LK1QNFHkI4ClEVL5vFxsSYWxtds3lfA+FQ
         tK3k6u+F/+RTf3SXcDxjYy/0zQ+zDOwf4AxSQO1m8rW8grXglCzR5UA+zxRroBHCjzJA
         Ngog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787761067; x=1788365867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wS8Isqy8j1V26xF5Dw7K3OrDRfOCKejghaID5rQbMsc=;
        b=a4QhHqXct0MduGzVvbw1MsWUUPpJFSF/I8Ms5YisVYGeSN9NfyA8AtB89KL4nhOoZj
         x/Uo8PTJ1pwKE5XHih44zVuP9NPAbjo6iQjan9/tq7zLQSUjSaQKBfzyerxUdFyFbVCv
         furBmExqjQkZNJYqx18G2+HvJixKoRKLG/ttfW+T+WyJ7gGoc7yR8EhfhMHKmc1K1GV0
         QWaEyY2m+ie898e/TtQ6mDD8E4I9CLXdFiLEYVHuJ/2ECB/xAKM0Kesw1FQmKnQUJBBR
         RtuLM2mxblQGWognI6/k8wF3kCdlvn2LDCo6pFLLq1/0wobE2KjgUhJnC5GvaOw37NAa
         2tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787761067; x=1788365867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wS8Isqy8j1V26xF5Dw7K3OrDRfOCKejghaID5rQbMsc=;
        b=D+Eku+C/IFbbjddVmYlOIijNqjO2JxCH+JEBrEhSOPWSdIjckPrgwi94Q1nSS7hLk1
         2qHMv3gc7xw1+1FDfu46kQ4z8Qx+kbJC8GZdCcb8ptlfMhdUPTaGQYfwbCZS1ciRLeXO
         DhaSPBkOOh8HnlaoHTTRC8tMXCOH6pzI5eiCdo8XMRdKB4Bgj7ps578eUHh81FGP6uE/
         px8KQJFSS/Yp5xhq81L8yVyd3TKQe/usa7rLZJn1uX8P0LaCUuV/GSzKDsQF80n8C5YJ
         pHBrILajvmXqE41olDn8lwacrFw37CeJheSg5VNbbJ9cG1XJwTVthLSmR9P/Vnw9bgr5
         Vj7A==
X-Forwarded-Encrypted: i=1; AHgh+RqolJvVUNVC4GqDhCBcFIlJL4zSXj/ZdT4PuFYme0OYU33A4yCi/qKvvGNqDGoMkrfzTt/wfik8rl4A02AD@vger.kernel.org
X-Gm-Message-State: AFuF++lzB+fJWDvtTb8DnLgK2btuFJ+/w316amzuv5mlFqPvXojm05Lg
	vBUo1JW7b/ntxloSYp1jJ/RKtPexa2jvfXPkzKftlRV43NhJa404crv/KqKb+KftsdS6+cRJjdE
	5qOhiyEzMGe5FTPvJEixE3OuoHwImg0m9jEHrFpSo
X-Gm-Gg: AR+sD12T+i/iQv/iVGmxZW4VJ45g3lbCZs3S+q9JfSn/L2L4Rl7HW/8G+7QJLJkkn77
	v2skvlylq21ma0E0zTsZMe7JWwPWKaBz8fjhR9djjbM2mG2HQfZB4KJ4xMi0dSGX3cZabjKm7PP
	2TMYSl7OvQgWGw9lmJ0YC3kUMAhKUmxxFfQLrcHU2uofsYTabTrx6MN5KZykAD17br6G14VEQWG
	9I8YNRhsVTRsqhtAxcm6vj1fqAiecZ4NFCnJQ2266Ab05KK6Z2hthexHP/bpWGsaQ5wDjtweoui
	6HJYJUBPv+PKDpR1hhms8fDOfViMg8rp6sCF2gIgobYDaZNIJBuaAdXN69x+LMx9UtCFOdKJzcj
	3RtexnyqDhCEg8aGlxniu5uz64jV8DA==
X-Received: by 2002:a17:903:1a2f:b0:2d0:1aaf:daec with SMTP id
 d9443c01a7336-2d7105043bfmr5843385ad.9.1787761066499; Wed, 26 Aug 2026
 09:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <20260825-unweigerlich-biotechnologie-abnormal-accff844337f@brauner>
 <CAG48ez14F42BgHm5dKeP4g8D_6CNhnAfF7BXdcBwa4NdtFiaiw@mail.gmail.com>
 <20260826-juror-energetisch-hackordnung-83810c82adcf@brauner> <20260826-rotor-heterogen-wollust-2091c20f5e30@brauner>
In-Reply-To: <20260826-rotor-heterogen-wollust-2091c20f5e30@brauner>
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Aug 2026 18:17:06 +0200
X-Gm-Features: AcwNN1XyOejgP8xhG53At4w9H1ZIts9vwM506J2nZcs81pxFYrfApeUAbMczaOg
Message-ID: <CAG48ez1s-=GB62T6k5NFjkgsLYJN_eYhDwT2U9UXeTTCZBV_UQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 3:01=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Wed, Aug 26, 2026 at 12:29:14PM +0200, Christian Brauner wrote:
> > It seems odd to just call a hook when it's introspection denied.
> > And if that's the case why not also have a general hook in
> > ptrace_may_access() itself in the introspection branch?
> >
> > I would actually have use-cases for this btw.
>
> To be clear: I have no quarrels with this going in as is. I'm just
> interested in how policy decision such as this can be made more
> meaningful in general. If you have thoughts around this you want to
> share, please do.

A distinction that might be useful in my opinion would be to
distinguish between read access to memory/registers (like for
collecting information after a crash) and write access to process
state like memory/registers (which would only be needed for actual
debugging or fault injection). However, ptrace() makes it hard to draw
such a clean distinction because resuming a stopped task can inject
signals with arbitrary signal numbers...
