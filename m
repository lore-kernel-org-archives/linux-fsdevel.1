Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418B3AA19B
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686264; cv=pass; b=fhYo29lDaacRvPGw34bVcN8ZTOrY1diTNjY7NhrMNyIgCtlY+u5CNvaU+L7QThcYDj+XsrEmULRv05jVLk2IXC4fP310O5Rp1cfr5xVYQBon6thEZcx0hY4Pk7bBXP5d4IyokQjudDzc0Gee4b1hODbOP6lA09d8HGmLHN+L5j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686264; c=relaxed/simple;
	bh=dNgSdype1mNwitZBXug95FkyN38/VTRy2nwLEQed+5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilQQUDFUH+T4W5k/EBFPWwDupDJD+MHGzmEBjsYpGql1mc1/QKJgzU2z032Xa2AJ7ZBSeB9tkvUoBxzFFWhCKm2bEACVStst7rrkN/7N5hp8W86N+kqp8lqh7U06NzqQfA4sh/Q6Efaq9cDs8b+5GIzgcHF0JI/dJIcOcs+WlHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlJWNiwJ; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlJWNiwJ"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-448b69cfc6dso247416fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 12:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787686261; cv=none;
        d=google.com; s=arc-20260327;
        b=TZuHmYcRQk4TU6W1urDqmSE1DBxDiCo86pdeH7YhtQvH+GnHSys8yblGogtlV3qWkz
         fLcmaOPlHJLgbldaiwVEpKI1X1yqGWYnzl32wQys54e30BzHgVwEjdpfnKTbrI8ptIT8
         t6c6jVD3FPv1whdJfB64+Xw63JhkHX9+MzGfTbF6ys5T1DKyGY9YmUVWjgE16wPJuwCb
         yHR/sAJRM3s5kuysCPU/Z/EH8++XrfW9zRKqLWPk5ks2kpT6cJheUeKgIzKk/skrDZik
         iLeAy6y7Mdqu2N4wimlow2jPt9CCWjt24pWJDoNhEsBDR2ykQg+Z/+WtNyTLHD80ElU7
         VSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dNgSdype1mNwitZBXug95FkyN38/VTRy2nwLEQed+5U=;
        fh=ryPjliGURudU+xn6BCxQo3S/GJSu4sUwOAggBnE7rNw=;
        b=FvcdYZUs+k5Qn9HfTjBzRSW/NUGgofjAP0SkSOKcjFkj6xKuM8GKPzj+2TJun8QCyq
         6YbXxV47qUjNOEqTR0yHN7aKXKUziWbuHC9CmUedacAprxiyR3+7dSAA0X+YzUQJuCiW
         S41Jb4eTsyI3AY+/yVtEo89Yo8fHO648aq3UUsdLgHEixb9FbDAvEEf+cfxWoJQK0zJ1
         vXHxr7Hcg+0Cf8Ox14mzig0cgcfN7vG+6mWDhbHIEB6nRWy2bxDVE/o7R+FHEdtlmVfi
         9BPsyoFzdMsvRs4FbYHiJSabRnsSOLzj0jor0GA1mOEvAPO50pzDqCUWxKH+4rYD6yBP
         ElAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787686261; x=1788291061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dNgSdype1mNwitZBXug95FkyN38/VTRy2nwLEQed+5U=;
        b=JlJWNiwJGmpgyOEEilZgSritspdSWgKvEFEr1+tlWxGqv6bEGpsH27bcJ8FE9c3TYV
         gf5VeM5PbL8ez76NaCY5Fc2aYLjBTkS7rLfSVsFIZ0Odz/WT4aNILtXw5LXHqFZzcVk/
         CCDl7vfjAMnstulRBv2P0nBlv6socQxo1WpXTP52d/10YlZGNKGbt5gK9VFyROn7qxgZ
         Vdl4hEgmH9VuU66iMeq/Bq3TuOtKVlDQY5Mk2aeseGtKrMzsBBDJhokpe32jqg+W688c
         88KyrgJvdzRUG8d7Ra0e89jWN80mE+twx76kFYoZItZ9NEVEvEoQ4w0N6LTBQR2srX2L
         QAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787686261; x=1788291061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dNgSdype1mNwitZBXug95FkyN38/VTRy2nwLEQed+5U=;
        b=DHaRPpy8c4eUQyNHZx7pRMOoSO2fFjc70clvA3eIlmPR6ylT0RUYY3/Wg3wj5LGwtU
         9+Y/XKUBUx4u1sLLgzFcdyk/9RugB4tbdzZchEpIS8PXSkop4hl9mpw6gc/vnF7sup4s
         VeTjnxY9OxxSZqosAG1i3u3TZ6NBNWN7lRYTLlG8sDIUkJsh/ZUZ4BLOyg1Zhk4r2Z9l
         xFWDpDWwoLNL/Zs65RUAkGOLikIYwRiXfS3UhrSKV5ELcqsLnoQhkJnzkf57mwIGfHH6
         B0C5AYMbTSXbQQvntqSucypHtzr9aEG7BD/uVdQJp4e7JQTpskc4fGaWXVQQPffvc7cq
         GxSg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4oE7Fe2g2mjbT1UygmtkStOcC3x+w/Yf7fZj5/t0x1mmQ6OQRQvMY2RCARBXBmSaqOREFr1ojkGyCMfws@vger.kernel.org
X-Gm-Message-State: AFuF++nVJYofCBYYjrFAOEESqjoPQE6Nzb8fsFBf1BL9LSLKwbdpyu0g
	bLq815hrz+hGYpQZfRXzis63cXMA7jC+j3DPuvgEqVH1fXLRBT3sL3sQi88QbuaZTxO8ZbRKQG/
	fx6FZuCaX3t5u5DpBNqoLTpnEVcKSpp8=
X-Gm-Gg: AR+sD137jwBmY6PwJ9UFPVAHH87lIvorL1DW5zqaOO2OJNSK0AgisU49szwAWm17IBs
	WjSx/D18lMf6ruWSE1WiliFTAGrr0LE30IlkpwwIpSTqJz3KlJ4FYojYg8yU3L97f21Rn2sqRb2
	Ufwqtocuur9tPcogNsOS8M00InmC+T/03i71JjUPHEK3SKqUs4jHhOMmBfaKiQdJhsulyu4YT94
	SEG0qu2DmobRFpVTOXpKAy9wSGpwqPS3EwQs1A1bZW5FUnEPofCCeBcQM3KvNggCh4Tpcfwkq8C
	4DngthSgyETt2s+TOnqWjRL5mWPAvwOHm5rNipPXbCFiK9F0AEoumCA=
X-Received: by 2002:a05:6870:6110:b0:455:9a0a:f40f with SMTP id
 586e51a60fabf-4659af5add6mr1857019fac.12.1787686261101; Tue, 25 Aug 2026
 12:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com> <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
In-Reply-To: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 25 Aug 2026 15:30:49 -0400
X-Gm-Features: AcwNN1W7w3jv19S12dsWPPPWvBnTdscjqtDJ6w6TlqCes7086WzzU9lKHcWHgo0
Message-ID: <CAEjxPJ7ecY4msx_tGxW1bO9ywDpB0wRv3GtQyu2SnsGV9May_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE introspection
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 2:39=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process c=
an
> only create anonymous executable memory via /proc/self/mem if it has
> PROCESS__PTRACE (like when using /proc/$pid/mem of another process).
>
> This closes a hole in code integrity enforcement that Project Zero has us=
ed
> in a remote Android exploit chain:
> It was possible to use a memory corruption bug in a service without
> EXECMEM/EXECMOD/PTRACE permission to overwrite executable code via
> /proc/self/mem, which made it possible to load and run shellcode containi=
ng
> a kernel exploit.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
