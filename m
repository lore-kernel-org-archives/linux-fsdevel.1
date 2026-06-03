Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE33939C2
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511063; cv=pass; b=dTxWs/iXyRSQCxtR24sDYkV1VdvzWWxty5xtG+RO/VkOe/8jxbvJ7zHcejdoonbAuWvtOXy4MMSMFkgb3DUcA80gU8F0Fy1kgrWNsZW64jAGz+CqTetGUJJPDtwvQ9TjfSBd25+DtRYgaEFGHP+8i9U8HshZp2PhqqEIMYbOuYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511063; c=relaxed/simple;
	bh=HWdGSfSJ6XiOwsk/gmwA/nVjIEvHExoXM0cys0ZgUws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdzBirx/aoQXP9WvwL2iYsMrcOsJc5nGkLQvraoO+Kje9gNIJ/tSdCdzvSdndi5V75RFZkWESGBHBljFmfJxSlLSGWaEEDUc+TfEjRlr+75fJEKUMrsEVSzAkPIBQogYKjaw3n2l14394vesnFSrqzA6Xas4S65SuaA9KwRu8Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDW4VNKM; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDW4VNKM"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68bd7ec2371so1162a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 11:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780511061; cv=none;
        d=google.com; s=arc-20240605;
        b=MaAd//sKzCZ+n7qJ3oXQDxUSUeqg5bNgTqLejofKVoftktnSO4lefPOskmbdG51rKG
         MWcd6W9UBkfMh3dOmsp//c8H9RRB44Ln9F4d8T/fIGrnJ/Vf9AKmlMDS6tVREP10RE2g
         WjTCbyXf32iHOZQBfK82R55j5/bES1E34oXxi6lXtr9PyDTgvFutm+n6f512jEjYvErz
         pHLHUOkDpI01aSl7yQ7c30F1F71WT3bEooypjlFtEt6z4gJpMsWfLcc8IGcAOlSprqou
         AF6YX32BwBhIS9FyU5Fc5UaSIXUjgQBOWIa51VmyS+Kv1b6gB8rlLhqBkRhfFuF+hkWn
         zJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2c1pnarNV0BgrbYBT5WI/9g8oTdViMreYH98GUJuRCw=;
        fh=tsJ+VxHdzw1ljcvXIFBVZrH6v+SoeCKXCDeKr8aYMvw=;
        b=IhAHnHMu6KUo88PuTyYoGMnI0mwGDF4nNtF6OJZaRVfL1DDMtCxQlFoYQAgZGpYB0k
         ZuThnq4clBSpxTcP800mf0aSaw5WGE467F8StRaWEoSB5P3E11WVnlFFma2F+zCzsg6T
         TjdyeBbgU7urALljM8vn/H3F/bs+AeRdY9FDvnLIBMBnP3GtSgvTFrEtnnH5L5tIQsE2
         eiK82UEOQfXxbYDX4IIURHUO7Qst0v8253b9GeNzxXwgo7u57G3f4mqYpubS1A6L6r4h
         Kl2UFKKWgaQ+wO27fP0rXmZeqlfQ6Kl3NxKurSuKXmJeiaeY4IlohG5J/lmQJpkFvW8b
         8p4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780511061; x=1781115861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2c1pnarNV0BgrbYBT5WI/9g8oTdViMreYH98GUJuRCw=;
        b=WDW4VNKMeS1T1upBXj2gFftz54NnBPendE2Fw3Z6doAar8VU5J7nu5zsWtAtu3mx3D
         RV3T4SziMwoF+S6BRxkeYIPXCRM3z2HpM23w4d9NieV3rO6SNqrNGZaQmKivjSgYSknc
         TlCMaB2tdwVKgjPnosOKJ6jsbdfu1fCmWlMRBaTznJiYtAi7Ogg/OhhZIlxdGKUTorJE
         sGIAfHsNXH4rS/PJGrcI3vl0UGCRIEiBhNP5w0ZQb5/JeNcBbx/7N5Jqv0207U2fn7Ol
         8WkDdX3tSqmW7GqzZmCe9k9/5JvQxBXGbBSF8A4Jq4Fyaz+P8LdGSiJ5rvPuKhcoyCHf
         IlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511061; x=1781115861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2c1pnarNV0BgrbYBT5WI/9g8oTdViMreYH98GUJuRCw=;
        b=X9AGIcgZjtZd8u4MjvnMe5hyrHVG8awI6FuB7N27SBaS7mfqC4121MJpc41aLJyJm0
         BOpMa+OYapkyyBitFfdLA1r80fGTYEH4FYDvfrhWMPZbygPNkg68gVwMDPkt0P5S2t8L
         k+z4WRi+PahA0/Qxx2TL+FxtnS70JNIFiMfegQqglzYWRIqI0v2jpNSZoOb0rMjV66Hd
         rRnIcspw0slR3+MSgIkDcN5oVbQvHDHw/O4UscvwZvePOJhBOjxF2W4V3hR5DMjZCMGW
         5CdOmpM1G3ZWxzZ/KI85qHbAxnB9B1Rzi4GBqyXf4gz6ach0eKNb8AWfOQUqvHck9C68
         Eq3A==
X-Forwarded-Encrypted: i=1; AFNElJ953EwAJeu2IeNTEmHyfoEF3hvzXZKsac/s4/+4sA02IA7obcRbn7I+1kKHI6O8SVcO7OW5/ef0G6SXURg8@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNDgdtzS1NDtTwK5C7a4bFcOZFpn95iIvQ2FuwiuKFJYarMdi
	r7FYBIaiNpTQ68sfyqtr98ZIxTQ3qd//MfF9cWV45i2+Uml+WLfT3aSm0NKLtVbMiZccUQwOt6K
	l6XSc7Psct44lqvQt1W87bli3F1b9DVxg2F80z9mV
X-Gm-Gg: Acq92OFuSxyUhaLxu8iY+zatrn3sUlqeOlZAhIk52z89B4lBecQgkO/Z9tJxN2qJ2Lf
	taNsH2gr4BM6fTLNcmMrrR93dE2jiN3LL0GM1vZKpkDFXeSYzSo2hLdTvQ5GRsKuC7+AtKoT88N
	xi5jzx5O3n+SW9jYLHZzJAYYpgAtyN5j++YAM443HX5tjO8pYcejlK4QkGMOdJdCN6eMIvyg1oE
	N1jpaS1iaMRakwqfLNN/0KcHnKimcQQzn3IAog/GBoJBCrFX3JAMXj4U85W7S/0Upr6PgKLd/+L
	/UI2/bWToADhLmcH6iF5La+04x/Q2rU7G7vAHB0Tw23OYZAYFwfhPOICizQ=
X-Received: by 2002:a05:6402:4d:b0:671:fff6:f82c with SMTP id
 4fb4d7f45d1cf-68f120888f3mr9598a12.2.1780511060391; Wed, 03 Jun 2026 11:24:20
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com> <20260603181523.GW2636677@ZenIV>
In-Reply-To: <20260603181523.GW2636677@ZenIV>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 20:23:44 +0200
X-Gm-Features: AVHnY4KcxLLBzYv04O16lPgfRsGmNsi92bRo0L6SiX4sR-aXpPDHaC3GJOZ42Y4
Message-ID: <CAG48ez1DGQ8MbFWWi+n0Br84cBF_wSrNgPqd+NSxAcbAK7WR7g@mail.gmail.com>
Subject: Re: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 8:15=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Wed, Jun 03, 2026 at 07:38:06PM +0200, Jann Horn wrote:
> > Fix it by taking rcu_read_lock() around the mount::mnt_ns access, like
> > in __prepend_path().
>
> > +     /*
> > +      * Containing namespace.
> > +      * Normally protected by namespace_sem, but there are also lockle=
ss
> > +      * readers (which must use RCU to guard against the namespace bei=
ng
> > +      * freed).
> > +      */
> > +     struct mnt_namespace *mnt_ns;
>
> Umm...  It's somewhat subtle - at the very least you need to explain why
> there will be an RCU delay between umount_tree() clearing that and
> having the sucker freed.

I guess I could write something like this instead, to make it clear
that this basically follows normal RCU rules, except that this code
isn't actually using RCU markings and accessors?

"This is like an __rcu pointer which is protected by RCU and
namespace_sem; however, because most accesses happen under
namespace_sem, it is not marked as __rcu, and RCU access is done with
READ_ONCE()."

Or we could put __rcu on this pointer, and annotate all the locked
accesses with rcu_dereference_protected(...,
lockdep_is_held(&namespace_lock)), but I guess you'd probably prefer
to not do that?
