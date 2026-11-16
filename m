Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794815585;
	b=I11+uKcTXnmeg1mJNV+OLi15CdHtO3xkU5GQ0gb5mmFnzUNcmHKu9jRslYF2FSZM+a69
	 If6ycm6MJ210yWoqfkF+ZD3c3zqrNvs5XRNb7z/t9LkFldInJrpQtD06YiMuJnR7cYmPF
	 uGs0Bf6cZvvwA9eUj4A7yyJ+zOMPAiUvA2yqdpEOgcv4SCxBq3geBdnTvEzZzQPQ7XXIM
	 sNIRRoUwm8vGIS6OrmZ6dVy6CauKna/pxOtELp8OXwfYbKUw5ZTm9BqNDJgP0RoouNYn0
	 BazDj92+0F9fpdQxJCPcjR1jah93ItRMHCtGeV/GIisKlJQRMrqwAnhsHpdaGA9jG2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UgwxB0CUQZVHTHzWqKlMmVXnP07V5Zuytgbvn6PLPMg=;
	b=DnP06qP0z1Cjop3Ht2ngxEaEP2Fg1tbHj2AHE8EuH+GH/oawSyCYjhQwY3riSo0iPHHz
	 C+slSyHTt+F3cem1P1w0+SN1cbYP985MIRrZVRsgp/nh+scV/L8oDEHrONx9ttJg/f+mK
	 aSr9VjecZlfIdWhy9zjwYQO+Yqu5Uw19pnF0sHfLdTXU214Oh6/ehrW/1xldO/WBnKixa
	 OlVIDgSDDe9pYfYYsQ6v0+zq1xKEwrdzVt4XYJn9b2kP4gY/OgUb2jgPRxIGg5RWNy+/I
	 TS5f8JrxLw5PtOdtSIdWmqQIZpDL4dAoJHgoG0kaXGbvyk9111scZZ8/rMq5Q367Pmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b="R/Xqf3OF";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA20606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 07:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AA20606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=R/Xqf3OF
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b81214ab40so1626490a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 23:53:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794815579; cv=none;
        d=google.com; s=arc-20260327;
        b=JJHwcE7/37+/JMxzYlBvsUmKaBMP6qjWJXUZDdXDzu9mD7uq3/rM7OWFDoPOpreraS
         PxxGXIxavAnS6CH3HMLB2NuVDv+MxOzL7BgXFbsCYV5RwJGkC8kwye26XtrDCYJ4kWzQ
         Rq7NrYMInVVPmaLlIEPc6iKcXXBLyoZ3AxUOONDnv60htwdl2+sIeU48kcxOORDLUdF/
         zf3CiM7AAADA2NIX5Rt2eIRT+2jvsl+pKcqXUS3aHL26yNV7VCHHFIXVraNJo65Uw24m
         gHkDjlahZky7YrqioIsMfq2iO634iRzaR/lTsapAsCS9HDGFA1Ns8MUnM38hgVeCvLJr
         IvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UgwxB0CUQZVHTHzWqKlMmVXnP07V5Zuytgbvn6PLPMg=;
        fh=2TDD2C85sklnR+VRJ9TuC2LNJsbauhz4yDmhoCki0/k=;
        b=jBMarQejBHUAHvlNNGMAl/YDwbVnn7DWwxv8/gOmy2O5b8+clvEHZAzeuptC6b91bm
         z+hYVv2h4vBVhIX9oF+Ze0T9+PGsRA4mg7wi6/wi/lt/xYruQ6Jitpb0XM8v5noCEeni
         LmICGTVAiSXcuxYB+1KQ+rLQJSzrfgezg5TlEw6ALTccjFT5QU/wDxEtWl/nyQK318UI
         i9gyb7ddhoXnl70JZNKcVh7H12ft010XIB4G70/dxQmW8hdLg6/4k83smrHCbdGV9yOt
         1ylmstRcDz+ZWsjNXQ1pjKGaavqkTq4B1Gikz+qSq81DVQ7xzrWl3if8bqkrDtAOfNnc
         EXmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794815579; x=1795420379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UgwxB0CUQZVHTHzWqKlMmVXnP07V5Zuytgbvn6PLPMg=;
        b=R/Xqf3OFeXbIA+6kaUMt7STSO/vSACLvoqRIJFQDuUzF0TZ+OA+FXONCxj+xPwLnVz
         pLZGgMswFS9noXdYq7FTPZ16mtFzoggggD2OYv3Keb61mYq2BhjX5/mhBZEeLvVDRpZ+
         Uhay1BIzlRBGdy41ZzzZi7lQANLfMaHWQpgVjs50JsbI94clJRjwP6S2ufwZ1nPZNyuz
         XMjROV0Zb7xtZS0qK001rcCDhbGQTtsJl2jvge1T1tl4/c+fW9pRPCkHNsj6ikJTOOhw
         ULilNAMvg82caNalkQ8E2jW8qHl1L+Vl5MCYWEmdFoKB44aYaYOCHuETksIA5iO4YWdB
         RjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815579; x=1795420379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UgwxB0CUQZVHTHzWqKlMmVXnP07V5Zuytgbvn6PLPMg=;
        b=NFSCyNWJoviBQ/T+LfiW3HXvmPKR59UBc0QjqKsS9MtyxDD5vV1fh9V+0ZyA6w+00O
         OsyT+PkQ1ktp7VujqzIif+xdkCKAztXiL40lPun+2wt/XD3jLeKUiprDuM9eeH/hiYGB
         pNC8LTRD4K38b76RIJFIgXhUGj6EN0CZml6uWM+CxQ/l5Lta8BHw3gIcgaVi2B8+NUb8
         brmtTYEODS7gmLygogrRIudYDqUhJaqJS1Xbsc66eZ1YugxxJhgF76IBBxbzANhba3uY
         GUxhPQNCV8knSGnlqj9AwuOk7+AyiHg8LcR8iXrECzUmVR/GMoFBllfIPJ/6DdSmiJKF
         4w3A==
X-Forwarded-Encrypted: i=1; AL+hErHgD6QgM9FL357IFOb7+avVh+iiorS5ZiBUlAxZqQgEtX/3qmX+vuA4gfTqJaMYhGmWbOm79bZtwBzTncL/@vger.kernel.org
X-Gm-Message-State: APuU4Z9pyvyH51L3jr3sfIhcV9xjHGYUvKPuopyKUzXM2/cyx2XhEx2n
	i1mNIzcpozkChK9iQhruMvNy+rxxZOYB8Bvuuy5VH6grarrqC7ghNSH5IY510gzP1wRpH88GlUk
	4M1ZihBOA4gN8asHS3INJDLFtNF7piFrpjWpJYEr3Zg==
X-Gm-Gg: AYBFou0YKSY4N4vqrxouwQwdS2z5Z3EBgqR5f8J+RKckntWayCGX5ne483YYRMRGeWt
	AuB7g1G0x2iOu3RcIf9s51UcazeFM+v+d8iKIqfLLt6us9pmn/cjTDf9inbSdZU1O6PYuEB5IMl
	rF4J/V/H0iI6fwjqooGeezVpiFsYuW91Xov76LlGdD45kki7odLplyRlQSCjc1VDu09VIh7S73C
	o8CG335qeIv1zWXIK7aoj7TXXrJ4ZJSP7e+NkyGk168Q1Cwn5rV3sUG9XsCWigk+YNWOA7nYJ/b
	VFsoLmmppUeszB63PgP3UKQtiqQTDIKrwiTeKh9EGGVv73OTCZVzutxcJoTx0vtGQivTjGRe/2G
	aHV4loKzbi/hRZEmXDuk+06lr/7AvjaQAG4TpVvT2UBJPue2eADCJ8vIagcUmiEsAXsU=
X-Received: by 2002:a17:907:8e88:b0:c3f:8c92:3b54 with SMTP id
 a640c23a62f3a-c507b02df5emr1096652766b.0.1794815578624; Sun, 15 Nov 2026
 23:52:58 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113114427.1845888-1-max.kellermann@ionos.com> <20261113203313.487a3839@pumpkin>
In-Reply-To: <20261113203313.487a3839@pumpkin>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 16 Nov 2026 08:52:47 +0100
X-Gm-Features: AclHuK-qC8ceaLIq02NfYoQUOEKVWL8Vt9ZedBXVcsFiZnDivZNMxvKeZwBeDOk
Message-ID: <CAKPOu+-=fcJayQsj+hVMPpp9dQNXkJp5QAGm+DV_ciOU1SykrA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: pack fields `i_state` and `i_fsnotify_mask`
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 9:34=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
> I'd use a different workd than 'pack', made me think of __packed.

What word would you use?

I think GCC's "packed" attribute is confusing and the name is somewhat
misleading - yes, in the end the struct members will be "packed" which
makes it sound like a nice idea, but it's really about forcing member
alignment to be 1 byte, and accessing such fields is UB, which the GCC
documentation fails to mention...

> > +#ifdef CONFIG_FSNOTIFY
> > +     __u32                   i_fsnotify_mask; /* all events this inode=
 cares about */
> > +
> > +     struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
>
> #else
>         /* 32-bit hole */

Good idea, I'll re-add the comment in the next revision.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
