Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F0385D86
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 04:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804319; cv=pass; b=Q0f28tL/Yh3vNgkiv1hxYjau0RgAonkyQmv9nFOU/s5uKkbqyRtOxW0VwjZmCgnGV2wKM7e4xIYZMVa4FLdmgdjABvMeYm45BPsqCivltfqNcNYEOmdChLddafmZ2T+MoDmXdomEWqzf/OgGRneVoX2Im9yVSxSdmcPMtz5tizI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804319; c=relaxed/simple;
	bh=vAkpENEL+aCJBuN6dUSQpHeziG23/MMgcrkzCZbrvzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4bvCQIkVfd+g+xuRuoZk7AviJ/t2nW4bTsrYY4fBi1w4vnt59W1v0ehkOWynwy1wzNeciMmYsbl6m6x2rJ8JjnOEquTapcgtleL0LuRgIkDiIXGVwQY4ONvr7z1ZhqBzGYiuRFFR/S7DuiKLyCX+GIchaJM2P1Auw0WOC9zuPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqajruhA; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqajruhA"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9693bbb962eso1124435241.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 21:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787804315; cv=none;
        d=google.com; s=arc-20260327;
        b=lSmeluoCt5cjm18KaK+nakUuBGU4muP/OO119+UlOrjR93xBkzRwd1myfFM+DuSzvS
         YAjstjBe+9d1syL9YRBj5uZcSn83ZoEd6jDfULxzg2IZvKg3KwTq6fWh1cW0ENrILejJ
         AxgHixKx0wsLDN09Zlpi1EvdX6ht8XE7DLQJ/HCAkAm1tujKa7e4XiWMjT4+UHI5MHCT
         olVgdT3vveN0j6NzYz0u4u1qDNr3qh4erB5I8FqYB0qmFPJDdjWh9GB+kKWy9g1FP1L9
         uL88yOc8lhYQE1ePLmKltoeVxFnVYhbz5FI1KzyIFuqx0SsXEkqTJiLA085vp6WKKEvk
         3r0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tdkvt93wxjyIEopPoQNCDcgWpKE+IyMU/m+EhcZoeq8=;
        fh=dsatsKmiL6bmXDukmYO01y4Gl681lyCkBgmHazeMdMA=;
        b=ZrzAhLqIgWcS50Wi4tsC1exWAztlPWqDxAGGZXpq5LeQzNlDQXRlh+tEDxvH6eNKUl
         feHzaNczIvnpTjjnCmbwmViTu2qZcQFxw0CIKAxXUk15Cw3ikI0dT3Vyz3/DkvsNGMwa
         ZQvOPnadFtQx+8sdDST6iefrWZ8T2bEmF9oRdDwS5TSBC+e0A2C0C8fhTru6h4ft4cZ2
         yMfr5RuP3AtzKeaT6U4ROLXVCvl50YuZOWqyrOPKORjQSWuz/iDpudA/+ysHyxhGNLj+
         Fuji8ckgTK201cna87aOq8a+no23YH6IbBnOl4FymmbD6+eRH9T2IG0VQzdyspZaZwfr
         KF4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787804315; x=1788409115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tdkvt93wxjyIEopPoQNCDcgWpKE+IyMU/m+EhcZoeq8=;
        b=ZqajruhAAWYYYQhMXzyhdyG+si8j3ZjzLPNpHv2Gym4Qzb8APtcj1L1VHDVXvgdJ7Z
         kY6lKx6FDw9/o9EqV4eQKJ/C2P0LoaI9Nk7dGd69MxwbCvfvv84f7Y9UTguNRjdC53p5
         RnGJL1uNIbZomZJNDlG7VTtG0B64QV2rqcfMstCAhaQO/4URwy76MncEmbn/tuX5peNw
         aix2Mm9S18vsUK+cvCkGffXpYkz2Y+Tvd9jzTb3E15cQP0htXsfaMrwJuCVMu5fbP9ID
         ae0Xm4S5GGm+KJ7VKOKyXeqmbfsH+ngbI5ztE4mhpihqoFoQHu3p7015mqVQrNtmdIo9
         Rb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787804315; x=1788409115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tdkvt93wxjyIEopPoQNCDcgWpKE+IyMU/m+EhcZoeq8=;
        b=FDhIFKMNtWwDsD434x6RSyxnlWnw6QvSfRA3vcVh5od4w2H9iL3AKwWvaiDV/5tK5I
         rKs52XHxt/CQtn4ntGKwW29qCe4c45B5vKa3M/KBJlsVMA8eUuzfyG8/IFbOspQpNEvg
         KSmL6xCoI9oud9jvmWfCJsmshtrGqI72HX/pS5PlKoqG9x9nbQ0JSsbhyJdljmtiXWrr
         bFTWaHjdipfVPBayN/DlcpK+EAdSbfHraxbcfvNPWgLV4uGFYVgpX0Ji839z8YKTPXxf
         HDDEiSgMRLaTcKfy+mZ3dO9jbcOIJJwwojZwsHPX6f9YUednVGX45tjYCf7q0DIFKtfp
         Jpow==
X-Forwarded-Encrypted: i=1; AHgh+RqQMLZbqKYYzansuH+VYelKg4DxF6Xm5VupQAWbFb5ASdp6v+igH0EFglJJs0gZ+Kx9OUAek0VlzUSiDFnt@vger.kernel.org
X-Gm-Message-State: AFuF++kOD7N6wqLgvT1KN0VQlKM8o+3uOye7BQYRohO0Gs5xZROCekSF
	vBcdFOGtxLvo5p7rmIUBF822znJHbWMOwjRZzV9vIKZTr2POPRelYbwiDUcdlf3T69v6EgEVJfK
	T/lKoLglG0Zx+ge+b0IO5EjmFhPH+HJEFjKrnpqM=
X-Gm-Gg: AR+sD11Z8GHMVWuxP5gBdl8YBA6Xb5kQmz+XDUbOYeb8jR9Q8bsxNk31HT8fcN7+vqd
	DHp0CHtXxFn5rvEIIODCHWztfcLTt+QCY/lS2k7MyqVEnAXvCeBhavgBqxPrFXOLBifytqwVulM
	BmdmU043pz2a6687tdIFGbaDQJywIKw7OuHpAD8UbmyuuM7gkfY81XV57qTGRIcEfBgC1mhPnhp
	kVgo+CAerQJSpL7ipY37dOgWFB3JK/D2ODy8DOlYws4sNfN0W9NcjmPPeD+j0NjiUlegNVttDNK
	1sJ5YUr4mVK9HY9GmW1jSbu8x/PNDbOXa+iMN0GF292+LLqK4eumQbFIxhPAGwfdarVDHS82UBL
	WvmvjQfxu0w==
X-Received: by 2002:a05:6102:848e:10b0:783:cba3:cf0c with SMTP id
 ada2fe7eead31-783cba3f1f3mr1743406137.6.1787804314889; Wed, 26 Aug 2026
 21:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com> <20260810204118.1981755-2-morbo@google.com>
 <202608101716.FB6205EA50@keescook>
In-Reply-To: <202608101716.FB6205EA50@keescook>
From: Bill Wendling <morbo@google.com>
Date: Wed, 26 Aug 2026 21:18:18 -0700
X-Gm-Features: AcwNN1VUOYfbScz7X7OOfAgR-_09E5r2bsRAMzD6g11t2BR6ucealC6FacdfVSY
Message-ID: <CAGG=3QWmzsUtO2NMy4d_=qpyEfmeaojt8mjZh63V4Ep5vGLmMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: Annotate struct fdtable's fd field with __counted_by_ptr
To: Kees Cook <kees@kernel.org>
Cc: codemender-patching+linux@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 5:18=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Aug 10, 2026 at 08:41:12PM +0000, Bill Wendling wrote:
> > The 'struct fdtable' holds the file descriptor table information,
> > including the current file descriptor array 'fd' and its size 'max_fds'=
.
> > To harden the kernel against out-of-bounds accesses, we can annotate th=
e
> > 'fd' pointer field with the '__counted_by_ptr' attribute, referencing
> > 'max_fds'.
> >
> > The compiler uses the '__counted_by_ptr' attribute to track the
> > size of the memory allocated for the pointer field, enabling
> > runtime bounds checks under KASAN and fortified functions. There are
> > three places where a 'struct fdtable' is initialized, and in all of
> > them, 'max_fds' is set before the 'fd' pointer is accessed or assigned
> > in all allocation and initialization places.
> >
> > No accesses to 'fd' occur before 'max_fds' is set, preventing any
> > potential runtime false-positives or panics due to uninitialized count
> > fields.
> >
> > This patch was generated by CodeMender and checked by submitter.
> >
> > Cc: codemender-patching+linux@google.com
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
> > ---
> >  include/linux/fdtable.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> > index c45306a9f007..3a5c88291125 100644
> > --- a/include/linux/fdtable.h
> > +++ b/include/linux/fdtable.h
> > @@ -25,7 +25,7 @@
> >
> >  struct fdtable {
> >       unsigned int max_fds;
> > -     struct file __rcu **fd;      /* current fd array */
> > +     struct file __rcu **fd __counted_by_ptr(max_fds);      /* current=
 fd array */
> >       unsigned long *close_on_exec;
> >       unsigned long *open_fds;
> >       unsigned long *full_fds_bits;
>
> I see the alloc_fdtable test, that's one max_fds assignment, but I also
> see dup_fd(), which does the assignment after the newf allocation, so
> that looks safe too, but it might be nice to add that allocation path to
> the tests too?
>
Hi Kees,

I added a testcase for the 'dup_fd' path.

-bw
