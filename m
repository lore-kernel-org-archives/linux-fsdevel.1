Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED7F466AF7
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814892; cv=pass; b=llTLBvvLPHAEkPGYhIWI5O82fJ/R4ULUAK6hIqc2fON9QnZjrLrgC3LLLVZjNn6pcaFjJQGNtU+FwD2Jrdwx/26pB1A9yORSmAMVf3c5siYpLe+vXFM1R5nxL8cwtN+mFnU9yEDdoKktZt1dzEly7fHcns25FFXIazcnGJhaqNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814892; c=relaxed/simple;
	bh=CmafpcKng2OO7DY/6c28d2C/fmsJL+veaB1z/UaK3fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FA1liF14ouMfVaeojBpM7pGFS2fUethSvgMsNQiDlfjFs6zq09eXJiKdcBk0Xw0UwXVNV6iGcljmZwAkZJ1UfngVNPV1XAtvWUrNW9NpOerjboyScfY7CWi1gY9XsFVq39UvJONSc2PVkCMvc3NN+3VOq1QyiSROdxHJNb0JAIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWRdMM4+; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWRdMM4+"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a378f187bbso379790eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 06:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784814888; cv=none;
        d=google.com; s=arc-20260327;
        b=Te60JONqJhYx8L63/PbxRTV8WPh9p1CAwbzhbWQmvJVnW1xNV0nIAr/s4veoChMtkD
         TXgn8/vYasc8e/NQjjWWIK8/I91Zj80PqL+ei6Fqc5gtgx5rPQR/dcvQ8azMKdt6FKNe
         nAOwBJ9uNBzMoLVIHEw61T7qJ/puUUW+x76P7dl42M68wqRRgpJhOHt58rsA3rfxTncM
         dXDcPF7OjcGZiGRRNseqk0h08xS0zBQelwvolnVi26ZU+EcQ/4Mxe2k+xHj3A+y6JY5N
         AV1dfho5qvNp1to+oAly7Viyq61Boy0PnnZ7eUm6xj6hH/QjZ4iqOj8+dOnMShoj4SLM
         PQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CmafpcKng2OO7DY/6c28d2C/fmsJL+veaB1z/UaK3fw=;
        fh=w4lAgRe5EBy+2g73WvwQ+aeEFlthWKDrbl+OoYH2hc8=;
        b=i+K8uLm5nYY5YJeCRKRIaaMZdQ/H4R6YJPgIKtpaAZKlmk428HF7H3V9PKeqZ1eB6T
         LERCmhPYFzc6qIl+GmL21qUW3LyJRsAO/hu2pm5yVqTBs92qcosnBrFZeyhnH39dWf1E
         bvQFtykk5uSb4AoztidKVBVC6sC2/TNyNj5hOaPDVSLZNIWJhYcxjWamm+dtQN6TF/T5
         u1K11j8JTDJR7GeGqF//Y0UKU21bwWjCUJ97TpYrybpWrE/HjqKIvYIt7inLlMuEVO+i
         6kDRek1M7h8zCYOYQoYgxIj7XPEbhoB4n3qUC7vnwsqSGWXkbOVwGKiheE5YzO9Mcu4C
         xGPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784814888; x=1785419688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CmafpcKng2OO7DY/6c28d2C/fmsJL+veaB1z/UaK3fw=;
        b=mWRdMM4+mfGr8tMDFkk03kCPJHiG4QsiI4+3bnLn5NzusyvhuGf3AuUip0yz4RsjJ1
         JI5ZsJ0hPqOzuQjeE0tBNHF7lsFS/vMpGoajdX4dxqUYHudhTgoH+MS5MD+/s7aTdP2N
         VdDX65MqovTuiVuLNmOsqPcdq+F3zNyjGhPYwNH242qyuZtsk9RlkmQuwiBQuXKrIhZX
         0XLv8Fy1sWUHuaQ/JfzQ917kHazV13KxaoZNg9ukfMRZR/YUnLdJEkUd5O1k6akSEl1J
         c1DAt0Lwl2Z8pzEWFnGIu2GicnDxGiBjqGzUmO07NDM0aZ6ntlkQDUnRD5aShMXO1Wtl
         iP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784814888; x=1785419688;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CmafpcKng2OO7DY/6c28d2C/fmsJL+veaB1z/UaK3fw=;
        b=SVJnL2/YeUtOrQeYIcf12qUWEaich0Jj1TtvcmYLxmhJBBu37ZoZnDhJyIibR3reUu
         4mdIlYodXc2aCT0hyRGY+kIYWxw7lJUdPpTB5lTVWg/htAu4GjhIwwzcjGsSD7CW8dDn
         rSeL3pgFRqQK84qOP69zMz6IXRgiI/oovkyhROgAH646o05f8XlX6WOLaspzRUQLQgD7
         lGp7LWK2c47aLL/6FF5rw3nmeoJRNM2cPPkonv6uLL3cPV3xVmNn5LZKbJbJl6P3LYXU
         hlQcxo9DhH9rQgzhzGp1LET5HbUTXSLmSZM1IacEX2qgD3X7gT5rvauQMBeGVfIpdbmg
         RBMA==
X-Forwarded-Encrypted: i=1; AHgh+RprZtzs1xA5XVNJwO8R13cNylqIKC1YZ+o40HFYxhGOd27TziQcCZH1MFjNCffvEZuVxF78BXx4uTk+UMlW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IUqscIUIoUw5g+hsdk9nTvFG4FIdE2McQjQ9sbKJPTukmS5r
	m4F1AFyTAc1iLJvYykiHiN0wJbeYun/PSMcAIGhe2g/P1VgLhSPXCtGWJcINpvv5J+4Tq2VP6Y9
	3pP+b53KcwIsBwd86YpBH+gdLbO0c4d6vb/v1
X-Gm-Gg: AR+sD10BPzeFynLiwJaoWvaChxaCbaI7yG8k7GzeJIxxQwgKE47lhlxZCCnRPob/Hze
	8Fy8zUm2nInAou6n77oGyJhQFRQyUh2gfy7kThUiI/jwcvNOQZ88wWY3r6kzM9uE22lhSeGFozt
	ing4Taeop/RfOiWnM44HXLLELMfHIKRieDrhUo8qhFugusyGRQFjdfILV5t6B6ZJlFjweCXANWj
	zbXMH9w7nZcLylXm+5onVm81XSkq7LFghVQLIrMSv2U6t4RisLHx1pqKhUM9guRex3tKX0/DfQg
	ZLA/wkrxheUY15eGolRpONdcIZ/1uiKA35FviIgF7HDp/9D7lCVCWLHP3r+71gYDpYq+Ldqi4af
	Iuw==
X-Received: by 2002:a05:6820:c2d2:10b0:6aa:d5e5:52f2 with SMTP id
 006d021491bc7-6aad5e55627mr842071eaf.70.1784814888288; Thu, 23 Jul 2026
 06:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723114848.1212429-1-amir73il@gmail.com> <CAO8sHcn=b94SL6KTfPtnqau++-g9CXD0LOpPjp4L+b9cu8mMSQ@mail.gmail.com>
 <CAOQ4uxjk_Se3dq3exxd5WS98g287HUMjVAucipxBX=T0W-8d6A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjk_Se3dq3exxd5WS98g287HUMjVAucipxBX=T0W-8d6A@mail.gmail.com>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Thu, 23 Jul 2026 15:54:37 +0200
X-Gm-Features: AUfX_my_Kci5UbImKiXwv3CQsg2Nzgm60fpkVMYbljRrTwwreQ6BhrmzgsjkQTQ
Message-ID: <CAO8sHckGrgfPnyOC-V6AP+DakG8LBXTFRHZSchXxi02LPyfMFg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5] Proposal for Cross-fs copy_file_range()
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> As far as I can see, OverlayFS-to-OverlayFS, which is classified
> as FS_COPY_SAME_FS should not have changed behavior at all.
> That was my intention at least, maybe I have a bug (?).

I am sorry, I forgot to mention that all of these issues are issues
with upstream overlayfs,
not with your patchset. I was trying to make the argument that to
solve the issues that are
already in upstream overlayfs and to introduce cross sb
copy_file_range() we need to move
away from recursively calling vfs_copy_file_range() within overlayfs
(and anywhere else really)
as its internals are really not intended for being called recursively.

`ovl_copyfile()` locks the overlay destination, removes privileges,
and then calls `vfs_copy_file_range()`
on the backing files under the destination OverlayFS mount credentials.

This has three observable consequences:

1. The recursive VFS call accounts one userspace copy twice.
2. When the files are on different OverlayFS mounts, the backing
source permission check uses the
destination mount credentials rather than the source mount credentials.
3. Backing permission hooks run while the overlay destination inode is
locked and after privileges
have been removed. A permission listener that accesses the destination
can deadlock, and a denied
backing check leaves the destination setid bits cleared.

Clone and dedupe use the same `ovl_copyfile()` helper and share the
credential and locking issue;
clone also shares the killpriv issue. Splice does not have the same
mixed-credential problem because
its source and destination operations are separate.

If anyone else thinks we should fix these pre-existing issues, then I
don't think recursively calling into
vfs_copy_file_range() is the way to go. If they're deemed not
important, then recursively calling into
vfs_copy_file_range() is probably fine.

Cheers,

Daan

On Thu, 23 Jul 2026 at 15:36, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jul 23, 2026 at 3:05=E2=80=AFPM Daan De Meyer <daan.j.demeyer@gma=
il.com> wrote:
> >
> > Hi Amir,
> >
> > I tested the series on top of f6cde11eb46e and cherry-picked these
> > selftests:
> >
> > https://github.com/daandemeyer/vfs/commit/0b0e47d408311fe2b4a3e1711656f=
836b56e10f4
> >
> > All four tests failed.
> >
> > The accounting test reports two reads and writes, and 128 KiB
> > accounted in each direction, for one 64 KiB copy. The outer and
> > recursive backing-file VFS calls both account the operation.
> >
> > The credential test fails with EPERM. The explicit source check uses
> > the source mount credentials, but the recursive VFS call checks the
> > real source again while the destination mount credentials are active.
> >
> > The permission-order test times out because the real source
> > FAN_ACCESS_PERM event happens after the destination inode has been
> > locked. The process handling the event cannot update the destination
> > while the copy is waiting for its response.
> >
> > Finally, denying that permission event still clears the destination's
> > setuid and setgid bits. ovl_copyfile() removes them before checking
> > permission on the real source.
> >
> > It looks like the root cause is that OverlayFS-to-OverlayFS is
> > classified as FS_COPY_SAME_FS before the FOP_CROSS_FS_COPY checks.
> > That leaves it on the existing recursive VFS path, so these issues
> > remain even with the series applied.
>
> I am baffled by this statement.
>
> As far as I can see, OverlayFS-to-OverlayFS, which is classified
> as FS_COPY_SAME_FS should not have changed behavior at all.
> That was my intention at least, maybe I have a bug (?).
>
> If I am right and behavior did not change then what are you saying?
> That OverlayFS-to-OverlayFS copy_file_range() in upstream has issues?
> Are those issues unique to copy_file_range() or also exist for clone
> and splice and regular read/write?
>
> Note the overlayfs model - do every operation on both overlayfs mount
> (with user creds) and on backing mount (with ovl mounter creds).
> Taking this model into consideration, what in your opinion is broken w.r.=
t
> upstream [1] behavior of OverlayFS-to-OverlayFS copy?
>
> Thanks,
> Amir.
>
> [1] upstream + this fix
> https://lore.kernel.org/linux-unionfs/20260712122421.203113-1-amir73il@gm=
ail.com/
