Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CC3B5846
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569240; cv=pass; b=AHYA3r8MiaP6WjjHcRLDrz5+T5pf+z9j7LJZgmLJ8uznY9JlbpK1Oip46e2fNz9UmJb802x6UK2t5zkwRx8swVcFG06uPjKDr4P4ZADjySpRUx7ioMVQhkSrc/a8zRJm5Grz/ZHoSfnFMhN5CzIqjroVzu/rZx6epejk2S/02+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569240; c=relaxed/simple;
	bh=K7XcWTAG9pLSnk29MAn2WD3gdRS8+vQtAmNxqtasz3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gds+SY4TP1rWWy5zqxnenSxZOrANUgzsycO+grvenlymRomelLU3j12mlvLY2kOWN1dV+YDKBfIcMYZ77G/kssiSjwe+IxwX8VJi82uKd44b8uzB9Z/7l1/+gBlmwbl6QrvPgKVfQFBBoBPkkHSGldlXp+Aa5O6SZvDIeTV0wKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=enlP9BVP; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enlP9BVP"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d6ff3aca06so115035ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 07:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789569238; cv=none;
        d=google.com; s=arc-20260327;
        b=SPTSM+SR7fSgBnOf2Z6YS7oQJAkfdVafSILjy6HGAy7WlWxCXH/Z3ckRbAZvQKFU+j
         WOTlYGyPvyMHaTRmMSJ5771DTexwrYhqYnZnf0hDJJc7ivkJBnbPIqdCRxGacqsqyTJX
         qHuCaXMPbZc+KA0p3lPkU78sxVc3uTtTiDuS0Lwm12QUOhRwWbZO64A//VLa5dQjtNnV
         p20F+doHasudaxmxwU2xP5Ai3XiXb77QB1XkRXjXfJIiIeEpcJPsTKH3NHt1V9wij1qD
         4R1jwJo3CEY9f+ItrvPLEIF9X/Hy44liiVSGYLyzTUTpwtNFVtBb7Djh/ex9wpyzbm7k
         sfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K7XcWTAG9pLSnk29MAn2WD3gdRS8+vQtAmNxqtasz3M=;
        fh=AWJ76ttAFV0UqxAzFCoRXLY6/h5Wi26kSjYAVfJNKYo=;
        b=RVnzWvMso9V/7ne+CYJT2p+EZHEoU03oabqxsvP1Dhsc1HGu0092QXjYgWR4Wrj12M
         tz3gqoBWdnh3MuwwZjZNhy7inkIDGNMt3oXJP0h6Xlvoua5mc2w+wF1RoouVFSo/10QS
         9NggEorZkdQ1aNTGMT513z8DZ79emaASUF99gR6IPH03T2Ku6RuOOek2OZlL3yiDDy68
         BCTP6ciQYC0ujlcMhfsNOpQzBUJt/Ap6nSZuvu3dEUw8tuuxAV3XgnDdMXYaymyhFtcI
         ccSfI2HKp5IexVuxFm1DMspHkW3PSjRPOIhKo9RRPfCHiIZgmX74FNUsNI0kF9vH+kvG
         0nyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789569238; x=1790174038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K7XcWTAG9pLSnk29MAn2WD3gdRS8+vQtAmNxqtasz3M=;
        b=enlP9BVPCseMCloxPgKpmFrxpdvmDWfyw0wlrGMj5nishBaaJ++qgTLDrXA9Ls06di
         gRT8tck0R+uTqB/pfBhSFKpHY9Kkqo8WK22itILYNg2HPfwiLEh3J4cKiCmw1kVSNAkr
         aF+NAV8RWhfzoPcKayF6UJToDx4ykr10POgjLyAkuremzJuaGQRAr3/P5XbpraMeBGQC
         po1cw+Bi09jpVJhjja6omm4xsJ86Jo7TyBvb/aqYzXz4ld0q13dEJKANC9CxeaZdFFYi
         Hi1I8tlvYVmwYKDvQYayGmadLQDwtrlMNckw0PFBlVKM5R3qPNlBHXSMJ8iIT4gakwce
         uYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789569238; x=1790174038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K7XcWTAG9pLSnk29MAn2WD3gdRS8+vQtAmNxqtasz3M=;
        b=dxcw2HFTtBXzOIeuThPu8Yce73MK/XdQoUaWvcq5TOxt6EkJ159rlzdsJYMreWpXt0
         0fD02e63sXqTTfxX4HhvVH1tgKlF+QMJFPHa1OnXNbNIHr+r7SzvbzRREyWsnnMP2Xfw
         ce/HTZaVqrjEQoUluKdQdarxt8/4WBwTPVECqsLhVFGaB9nFFsgAfiYsvgK2ruwWQxms
         10zoZcyLID9saaDVLSEQxfLOrTJOBxHkU2g4qeTsehFT5NAcxO8AvOZZXfJuxWU1ATsf
         NfGBS/iZ0abXsnMnpQkor47kwVX5xy0klAK+vcs5HJ+7isR/nx+0GJGE1bjtaQsWg/a9
         tjqw==
X-Forwarded-Encrypted: i=1; AKwUvBxtFDKhy3UZnsyJ0IASis2MeY+Y7XT1kuOqukhM6Cz0WZOf5jBBaxXvo1i1/P4kkg8g0yHRCXD2jajtEYIo@vger.kernel.org
X-Gm-Message-State: AFuF++m0hVJNJCr8ooxv8afPoO7VpsD412/obKmPZAizgblTG8xnqu02
	/FSWd9WOe6u/1AG7iJw0XFh/IQ/B9mjhdp49JA1Xr+0y1AE774YZPkMkf94wDRsCe3YtGc/m53P
	jVHJDJ/yhwPx/zBm/HUPLejHMSCjZTUZeQefykDt4
X-Gm-Gg: AYBFou3xNIVb0PJcbrw1yXCjpaun3ZnUreHCETJqkiic0iCQZ00YqyAJIjjTXz9opjU
	8HbOhnWMjDji5j+iSxCPd9Jy8uEuJuPU8xv/tRZAc3tiB/ogJA0Zfhy8x/Q6JG63Ig/iS/qaycV
	9XhTwwMXWrTCCfT6UucileZ8VtIFXb0Nfu//nUiSuYi7kjZHIFFcj3iPqQxJOO8hu80GUw2AKd0
	XXRA34QulUcqeHxsqDGoQ+qtpng7RANlHZzzuPX+KPXAo4s6T/YCB20szizTEgJQHVLuFsWFCLO
	BQVY5rg9wS2V0+vD2YXhI6rTVLySoLRb8D+S3PCr4gdN4Thm7x2fwR/5umKwvCcNUnhCtbLeoT8
	0ulY1U4IiYcp9/D/tuvLg66iK5Y61bStSX7JwtKTsFw==
X-Received: by 2002:a17:903:1b70:b0:2d7:2a35:d14 with SMTP id
 d9443c01a7336-2dd8e92caefmr4932795ad.11.1789569237830; Wed, 16 Sep 2026
 07:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260910-wohnbau-bezwangen-wegziehen-7a32dcf237b1@brauner>
 <CAHC9VhTE82bRRSXSUuMOdrfoMh=xOb5hDvqiKWzBKD1urab3hA@mail.gmail.com> <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
In-Reply-To: <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
From: Jann Horn <jannh@google.com>
Date: Wed, 16 Sep 2026 16:33:20 +0200
X-Gm-Features: AcwNN1VHcCpN0atD-cxO0BibJJcgM5o-LVFXYygCh_MGPfeRHWgz6O_0BmL4XXc
Message-ID: <CAG48ez3DRgU7eQtF71EEQw72+xV5kWv0nQn==9uVd=YPyGhJUg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] proc,security,selinux: let SELinux block
 FOLL_FORCE for /proc/self/mem
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

On Wed, Sep 16, 2026 at 11:02=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Mon, Sep 14, 2026 at 01:05:39PM -0400, Paul Moore wrote:
> > For some reason (/me looks at gmail) your email never hit my inbox, I
> > only noticed it now while reviewing Jann's patchset.
>
> Oh weird?

(Same for me, I don't see that mail from Christian on this thread.)
