Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793533844;
	b=X15wkHMkV/ELCMDrtrdJflnxj+jAx5UzODMxMseF6Hm3gbx4hSCtoPiWxoorAIpBakmw
	 XME/Y+TOsho1Eo+ZBHfdoVIFzcss6vM4PvRlP+h6ySDaDPBk0XPXWVk/BCMix2ysj7yH3
	 eOn6m0nsETERCPw49XT+s+YJGmKqkROo/CEEWMqrsxo2UWQXsBkdqOe+twePssUzLYym5
	 91inJyLI59C7lX8/LRgLjoZCdJPjCcmf7oojJotgr3QeRYCqOfsoGNR2JQnbJUqxt+yqC
	 MgzTonV/oPqxM3N4kJhqHFiYdTR8neMNoa8Ttam1JGaZY8VYohkirmPa7z5ty+pz51g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793533844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=6BbJSAbA9xJpMB+DZoqrUpdzwrF+orIIb7WEUesZfbM=;
	b=a8Ckkc8OQ+uAQ5XJlU3I6NiaGEaxuvJzzQB2H36Roi8sHQYzeQnYzLzmwWl78NV0GzH1
	 OL3snZeQgUaKfOGKWbrveaFkI0FceT5LKLXSpXMLQDaa0Al0kFrlJZ8zV324LFxnpAg7W
	 BPO+FtDWLFP9Wq6wrkmaXWJr/GwLBXHjlTFuXMwC3v1epImL1zVxOg2DDChCO8dR5d6OS
	 Ykee7wn46FdfB7GKlRDhwXlq2o4dD2OuG5LZKDh/lA8nNq6qPMrUFdfCctfR3epsUfDT5
	 xIZsBNf+v1+x9OLcGkcb2UcG0sReJRbC+4LUgOyRI39vY48IgrgNpVqU4xS+Ofxn2IA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EPH0cDDG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E3606A324
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 11:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C6E3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EPH0cDDG
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c49c32650adso261538366b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 03:50:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793533843; cv=none;
        d=google.com; s=arc-20260327;
        b=mP7R1pXsfDqELRCewuWOHUXX1ghOlGMEFjg9zrPLWxri0O7n/u/DfzLayVlW9fromn
         vsynm2NVMiPQ1OtEhY3/Vl0TId0PBoUh//pyvWJDqxZdV2lynCaw+ilqTfLsjBnFU1Wj
         Hb4YtcdOojEx7WaB9NohGvadECvw9MTRU0ky+d32diG5g3DRPQRMGde9l782DOQVRMiZ
         2ASuF7WA8fh2dTdT41wDX61wxs5G4tJaJR01duKzqIKPYs+UafS1L/vzgg/fTeImNywZ
         CtiGzql2O7BxGDtKvZ+aYwEjiRL9H/2EVzQ/b6WzkgehAzY6GXcdGTT5QQzQ5pp5Pzla
         YarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6BbJSAbA9xJpMB+DZoqrUpdzwrF+orIIb7WEUesZfbM=;
        fh=EFdsfBbbkvffC5Ag9Dnw6faJCA/SNHG1+xMjRjI2TsU=;
        b=Q2ZQfZMHZMu4Gyn5pHxguNTHkYUNCS8M2V2KVCazf5/Gt86Gsf+N6uJzh0sr4sgsCa
         AFI10n6J33HwDSOnIYxuJMunLoO/h+ZdMyyDTYHhcfzbzAbk52IlGPtsTEJuJkIzVa1Y
         GDCYwx0xDFMtbHsmd/z2E97yYLELpyIQJIyEtElIu2Z0ateTqHzA+oVWl6eHXF7RF3lQ
         E5+HfkghJAfSllF5H5VkK2dc64jrDkzPH8ZekH3NOGFjudffJ8ul6xhuBvwJH74scmn4
         nqo17onAt21CHZ9FbkwvDnDeMtgHRzmbWPRLQWfpfnj+ylhAwAIxQXtSx0nJKkS5VVSF
         sc4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793533843; x=1794138643; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6BbJSAbA9xJpMB+DZoqrUpdzwrF+orIIb7WEUesZfbM=;
        b=EPH0cDDGs6JCTfcp8/rTP1Jndjl0s+DWpOcvBvMKvotLkOpcNmxkfOByxp+qPIrnhK
         BFulElW/IcdJe0/uYm14ZAjJDY2/TL4ustIWO8FHoKQc2ovjfGrsEQQyddxi2OFZ1rpN
         JkFaL0elawDSdpZktWhaKKC0/8NnzYQ+WyJYgtr+VVyzu57AualEzZ67tKCg70WScWGF
         dB53Bvf6MvNu5ZcE6skaraluFE+gs9c3W1axWX52Y+JRsvhm0/e5fird95BIkSF0912d
         oq5cx9Ao0IOGEZ8Um8DUZGzyfHxvJG72Azn1Y6EHGvsPNkMpg/HEhiKEu5TKwzCNXLf/
         sXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793533843; x=1794138643;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6BbJSAbA9xJpMB+DZoqrUpdzwrF+orIIb7WEUesZfbM=;
        b=xB+9OdPcG3GOuuBcMa+s12ox2wdqSnqU8+r7MM8/jeq5ufY9m+Rk1gsnAQZaoAvWcG
         hec//AAWJhX67OfF4a6+EBNYKPdx2THdC1VkVYF4f7yAzTH6Trx/UiKR6h1ExkrbdT3y
         jSnQwUwrAI9u/8l9POo87YF4tSqgUPH+5eOYrfUSE5iDR5vrwXZeDXd4WtFqAfu2Z54d
         WhWKMgxwaDQVWI01QkxBQMg7Xf+fOi5/4j98DmapEIzNszp3Fh1RzwrYNS3jsxsmZ0xU
         kH869fBhu/DV47v0mrfkDkuWugO3A8Q4p2gYM7S0iO+On8zcMrAkwnUpzwHMIHSRLeUu
         Vd2A==
X-Forwarded-Encrypted: i=1; AKwUvBxZonbPIgX6ImscdMPV1OmOGcOVabgESFBfhROGPKA/xPmVfVTA1j60avL6vuFsFN+elJQmorRmS8bC8+vA@vger.kernel.org
X-Gm-Message-State: APuU4Z/UojnK5rPAcqbXYmmy1YNNi7W6cfjQHRKACFPTzH3xquE/tfKX
	ozmGgQpOfwQbDNOVLl1a1uy5+AaBSCUY2Es+zkRRu3/GZgQYLwVCSTyP4RRg+A00cY6ugJwE0XF
	ygr4ueVNh5J3K/+VXs6yTsn7TLTJ3+Mg=
X-Gm-Gg: AYBFou2tCgwHAMOMhD7O5h8RqnNeCHAMoH1YkoNUzX6CEvdrhukEapf1HFJk1TNbYOj
	4To5h6GsCsaJEyi6XZS4pLwx67xaK2XVI0avGrQFiLv5Y+SWTnmZqb4orN48nDF7TVFUoKh+cHH
	8jB/1wkC79YIYmK28ErGkCoUWRg9vxgfic6Bwg7nT1wQRz5raFe8BqPgwuNRjRyLayhwTcdZhwg
	gnfaOjvcwIjQDMPDojAgCF3o/LtyF6kt8RTylkjKZGBQjPWx1B0MpG2IG3lGfzWH7agagngjEqo
	Btq8+ISH8usEYhJHVyVG5B4+zDzQ4+zr0eXjH5cd7XXE7qNGhuqb+OofWZf1x3VpBhiTpinaf3k
	oaAuMEN2I2tIbSMkYdwYZoF1expHTUnyJwSHaLGu/o9ch4lVNsXDSjzOC0cgNH4XWkvLj2A==
X-Received: by 2002:a17:906:eec1:b0:c40:80eb:c541 with SMTP id
 a640c23a62f3a-c4ca797660cmr584233466b.2.1793533842442; Sun, 01 Nov 2026
 03:50:42 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031095716.3030288-1-amir73il@gmail.com> <CAHk-=wiPhTLn1p0ZHx-7SMdk4_zazqDK1k7MMEn9scRfqeDgtw@mail.gmail.com>
In-Reply-To: <CAHk-=wiPhTLn1p0ZHx-7SMdk4_zazqDK1k7MMEn9scRfqeDgtw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 1 Nov 2026 12:50:30 +0100
X-Gm-Features: AclHuK9MY_OWodpNHuG3eEceVBrQxQNU6w6CnufQ4VmB9cLewZGlHWyfSMT3Qi8
Message-ID: <CAOQ4uxjNrdxZdZZipsqnUNq+TswCKqp+30iKRKCqh2WOQ-zKGA@mail.gmail.com>
Subject: Re: Return failure from take_dentry_name_snapshot() (Was: [GIT PULL]
 overlayfs fixes for 7.3)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="00000000000092905d065f35a3b4"

--00000000000092905d065f35a3b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 8:19=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 31 Oct 2026 at 02:57, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Amir Goldstein (6):
> >       vfs: add try_take_dentry_name_snapshot()
>
> I've pulled this, but I detest this particular commit. It just
> "smells" wrong to me.
>
> I don't doubt that it fixes a real bug in overlayfs, but I think the
> fix is entriely wrong. It is wrong in two ways:
>
>  - it incorrectly fails when the issue is a race with a rename (this
> is harmless for overlayfs and will just result in -ECHILD)
>
>  - it adds a bogus new "try" helper that I don't believe should be
> needed or exist
>
> I think the proper fix would be to just say that the
> !atomic_inc_not_zero() can indeed fail, and we should never retry
> based on that.
>
> But if we should *always* retry based on dentry->d_seq.
>
> And once you retry correctly based on dentry->d_seq, now the "we
> didn't get a name reference" is reliable: if it happened despite d_seq
> being stable, it's because we really don't have a name any more, and
> so we should return failure.
>
> Put another way: I think we should have just one
> "take_dentry_name_snapshot()" function, and it should return a
> boolean, and look somethign like this:
>
>   bool take_dentry_name_snapshot(struct name_snapshot *name, struct
> dentry *dentry)
>   {
>         unsigned seq;
>         const unsigned char *s;
>
>         rcu_read_lock();
>   retry:
>         seq =3D read_seqcount_begin(&dentry->d_seq);
>         s =3D READ_ONCE(dentry->d_name.name);
>         name->name.hash_len =3D dentry->d_name.hash_len;
>         name->name.name =3D name->inline_name.string;
>         if (likely(s =3D=3D dentry->d_shortname.string)) {
>                 name->inline_name =3D dentry->d_shortname;
>                 if (read_seqcount_retry(&dentry->d_seq, seq))
>                         goto retry;
>         } else {
>                 struct external_name *p;
>                 p =3D container_of(s, struct external_name, name[0]);
>
>                 // Try to get a valid reference
>                 if (unlikely(!atomic_inc_not_zero(&p->count))) {
>                         if (read_seqcount_retry(&dentry->d_seq, seq))
>                                 goto retry;
>                         rcu_read_unlock();
>                         return false;
>                 }
>
>                 // Ok, we have a name reference. Make sure it is still va=
lid
>                 if (read_seqcount_retry(&dentry->d_seq, seq)) {
>                         release_dentry_name_snapshot(name);
>                         goto retry;
>                 }
>
>                 name->name.name =3D s;
>         }
>         rcu_read_unlock();
>         return true;
>   }
>   EXPORT_SYMBOL(take_dentry_name_snapshot);
>
> (Note that in this version, if it fails it will just reutn the
> shortname in name->name.name, but it should never fail for a dentry
> that you hold a reference to afaik).
>
> Attached it an ENTIRELY UNTESTED patch that does all the other changes
> too to make overlayfs use this version.
>
> Again: ENTIRELY UNTESTED. Maybe I'm missing something and I'm just
> wrong on this. But I really don't like that nasty
> try_take_dentry_name_snapshot() thing. It really looks wrong to me,
> both conceptually and in being actively buggy and racing with renames.
>
> Hmm? Comments?

I like this. Small bug in ovl code.
Forgot to remove old take_dentry_name_snapshot().

Attached proper patch.
It's sanity tested but I did not try Chris' reproducer with added delays.

Feel free to apply and/or wait for ACK from Al/Christian,
or I can include it in my next ovl-fixes PR.

Thanks,
Amir.

--00000000000092905d065f35a3b4
Content-Type: application/x-patch; 
	name="0001-vfs-take_dentry_name_snapshot-may-fail.patch"
Content-Disposition: attachment; 
	filename="0001-vfs-take_dentry_name_snapshot-may-fail.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvxrlgqn0>
X-Attachment-Id: f_mvxrlgqn0

RnJvbSA2YjAyNzA4NWM0NzBhNjY0MTc4M2EzMGY4MjdjZDA0N2E3ZjdhMDcyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBTdW4sIDEgTm92IDIwMjYgMDk6NDc6MTkgKzAxMDAKU3ViamVjdDogW1BBVENIXSB2ZnM6
IHRha2VfZGVudHJ5X25hbWVfc25hcHNob3QoKSBtYXkgZmFpbAoKVGhpcyBwYXRjaCB3YXMgcG9z
dGVkIGJ5IExpbnVzIGFzIGEgYmV0dGVyIGFsdGVybmF0aXZlIHRvIG15CnRyeV90YWtlX2RlbnRy
eV9uYW1lX3NuYXBzaG90KCkgZm9yIGZpeGluZyB0aGUgb3ZlcmxheWZzIGlzc3VlLgoKUXVvdGlu
ZyBMaW51czoKSSd2ZSBwdWxsZWQgdGhpcywgYnV0IEkgZGV0ZXN0IHRoaXMgcGFydGljdWxhciBj
b21taXQuIEl0IGp1c3QKInNtZWxscyIgd3JvbmcgdG8gbWUuCgpJIGRvbid0IGRvdWJ0IHRoYXQg
aXQgZml4ZXMgYSByZWFsIGJ1ZyBpbiBvdmVybGF5ZnMsIGJ1dCBJIHRoaW5rIHRoZQpmaXggaXMg
ZW50cmllbHkgd3JvbmcuIEl0IGlzIHdyb25nIGluIHR3byB3YXlzOgoKIC0gaXQgaW5jb3JyZWN0
bHkgZmFpbHMgd2hlbiB0aGUgaXNzdWUgaXMgYSByYWNlIHdpdGggYSByZW5hbWUgKHRoaXMKaXMg
aGFybWxlc3MgZm9yIG92ZXJsYXlmcyBhbmQgd2lsbCBqdXN0IHJlc3VsdCBpbiAtRUNISUxEKQoK
IC0gaXQgYWRkcyBhIGJvZ3VzIG5ldyAidHJ5IiBoZWxwZXIgdGhhdCBJIGRvbid0IGJlbGlldmUg
c2hvdWxkIGJlCm5lZWRlZCBvciBleGlzdAoKSSB0aGluayB0aGUgcHJvcGVyIGZpeCB3b3VsZCBi
ZSB0byBqdXN0IHNheSB0aGF0IHRoZQohYXRvbWljX2luY19ub3RfemVybygpIGNhbiBpbmRlZWQg
ZmFpbCwgYW5kIHdlIHNob3VsZCBuZXZlciByZXRyeQpiYXNlZCBvbiB0aGF0LgoKQnV0IGlmIHdl
IHNob3VsZCAqYWx3YXlzKiByZXRyeSBiYXNlZCBvbiBkZW50cnktPmRfc2VxLgoKQW5kIG9uY2Ug
eW91IHJldHJ5IGNvcnJlY3RseSBiYXNlZCBvbiBkZW50cnktPmRfc2VxLCBub3cgdGhlICJ3ZQpk
aWRuJ3QgZ2V0IGEgbmFtZSByZWZlcmVuY2UiIGlzIHJlbGlhYmxlOiBpZiBpdCBoYXBwZW5lZCBk
ZXNwaXRlIGRfc2VxCmJlaW5nIHN0YWJsZSwgaXQncyBiZWNhdXNlIHdlIHJlYWxseSBkb24ndCBo
YXZlIGEgbmFtZSBhbnkgbW9yZSwgYW5kCnNvIHdlIHNob3VsZCByZXR1cm4gZmFpbHVyZS4KClB1
dCBhbm90aGVyIHdheTogSSB0aGluayB3ZSBzaG91bGQgaGF2ZSBqdXN0IG9uZQoidGFrZV9kZW50
cnlfbmFtZV9zbmFwc2hvdCgpIiBmdW5jdGlvbiwgYW5kIGl0IHNob3VsZCByZXR1cm4gYQpib29s
ZWFuLgoKU3VnZ2VzdGVkLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvQ0FIay09d2lQaFRMbjFw
MFpIeC03U01kazRfemF6cURLMWs3TU1FbjlzY1JmcWVEZ3R3QG1haWwuZ21haWwuY29tLwpGaXhl
czogMTVjNmJkNWNmMTA5NCAoInZmczogYWRkIHRyeV90YWtlX2RlbnRyeV9uYW1lX3NuYXBzaG90
KCkiKQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRz
dGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgotLS0KIGZzL2RjYWNoZS5jICAgICAgICAgICAgfCAz
OCArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogZnMvb3ZlcmxheWZzL3N1
cGVyLmMgICB8IDEwICsrKy0tLS0tLS0KIGluY2x1ZGUvbGludXgvZGNhY2hlLmggfCAgMyArLS0K
IDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZnMvZGNhY2hlLmMgYi9mcy9kY2FjaGUuYwppbmRleCA0MDlmODQxZTA1OGU0Li5m
ZTAzN2E4NzZkNzY3IDEwMDY0NAotLS0gYS9mcy9kY2FjaGUuYworKysgYi9mcy9kY2FjaGUuYwpA
QCAtMzU5LDggKzM1OSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGRuYW1lX2V4dGVybmFsKGNvbnN0
IHN0cnVjdCBkZW50cnkgKmRlbnRyeSkKIAlyZXR1cm4gZGVudHJ5LT5kX25hbWUubmFtZSAhPSBk
ZW50cnktPmRfc2hvcnRuYW1lLnN0cmluZzsKIH0KIAotc3RhdGljIGJvb2wgX190YWtlX2RlbnRy
eV9uYW1lX3NuYXBzaG90KHN0cnVjdCBuYW1lX3NuYXBzaG90ICpuYW1lLAotCQkJCQlzdHJ1Y3Qg
ZGVudHJ5ICpkZW50cnksIGJvb2wgcmV0cnkpCitib29sIHRha2VfZGVudHJ5X25hbWVfc25hcHNo
b3Qoc3RydWN0IG5hbWVfc25hcHNob3QgKm5hbWUsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkKIHsK
IAl1bnNpZ25lZCBzZXE7CiAJY29uc3QgdW5zaWduZWQgY2hhciAqczsKQEAgLTM3Myw0NCArMzcy
LDMzIEBAIHN0YXRpYyBib29sIF9fdGFrZV9kZW50cnlfbmFtZV9zbmFwc2hvdChzdHJ1Y3QgbmFt
ZV9zbmFwc2hvdCAqbmFtZSwKIAluYW1lLT5uYW1lLm5hbWUgPSBuYW1lLT5pbmxpbmVfbmFtZS5z
dHJpbmc7CiAJaWYgKGxpa2VseShzID09IGRlbnRyeS0+ZF9zaG9ydG5hbWUuc3RyaW5nKSkgewog
CQluYW1lLT5pbmxpbmVfbmFtZSA9IGRlbnRyeS0+ZF9zaG9ydG5hbWU7CisJCWlmIChyZWFkX3Nl
cWNvdW50X3JldHJ5KCZkZW50cnktPmRfc2VxLCBzZXEpKQorCQkJZ290byByZXRyeTsKIAl9IGVs
c2UgewogCQlzdHJ1Y3QgZXh0ZXJuYWxfbmFtZSAqcDsKIAkJcCA9IGNvbnRhaW5lcl9vZihzLCBz
dHJ1Y3QgZXh0ZXJuYWxfbmFtZSwgbmFtZVswXSk7Ci0JCS8vIGdldCBhIHZhbGlkIHJlZmVyZW5j
ZQorCisJCS8vIFRyeSB0byBnZXQgYSB2YWxpZCByZWZlcmVuY2UKIAkJaWYgKHVubGlrZWx5KCFh
dG9taWNfaW5jX25vdF96ZXJvKCZwLT5jb3VudCkpKSB7Ci0JCQlpZiAocmV0cnkpCisJCQlpZiAo
cmVhZF9zZXFjb3VudF9yZXRyeSgmZGVudHJ5LT5kX3NlcSwgc2VxKSkKIAkJCQlnb3RvIHJldHJ5
OwogCQkJcmN1X3JlYWRfdW5sb2NrKCk7CiAJCQlyZXR1cm4gZmFsc2U7CiAJCX0KKworCQkvLyBP
aywgd2UgaGF2ZSBhIG5hbWUgcmVmZXJlbmNlLiBNYWtlIHN1cmUgaXQgaXMgc3RpbGwgdmFsaWQK
KwkJaWYgKHJlYWRfc2VxY291bnRfcmV0cnkoJmRlbnRyeS0+ZF9zZXEsIHNlcSkpIHsKKwkJCXJl
bGVhc2VfZGVudHJ5X25hbWVfc25hcHNob3QobmFtZSk7CisJCQlnb3RvIHJldHJ5OworCQl9CisK
IAkJbmFtZS0+bmFtZS5uYW1lID0gczsKIAl9Ci0JaWYgKHJlYWRfc2VxY291bnRfcmV0cnkoJmRl
bnRyeS0+ZF9zZXEsIHNlcSkpIHsKLQkJcmVsZWFzZV9kZW50cnlfbmFtZV9zbmFwc2hvdChuYW1l
KTsKLQkJZ290byByZXRyeTsKLQl9CiAJcmN1X3JlYWRfdW5sb2NrKCk7CiAJcmV0dXJuIHRydWU7
CiB9Ci0KLXZvaWQgdGFrZV9kZW50cnlfbmFtZV9zbmFwc2hvdChzdHJ1Y3QgbmFtZV9zbmFwc2hv
dCAqbmFtZSwgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQotewotCV9fdGFrZV9kZW50cnlfbmFtZV9z
bmFwc2hvdChuYW1lLCBkZW50cnksIHRydWUpOwotfQogRVhQT1JUX1NZTUJPTCh0YWtlX2RlbnRy
eV9uYW1lX3NuYXBzaG90KTsKIAotLyoKLSAqIEZvciBhIGNhbGxlciB0aGF0IGhvbGRzIG5vIHJl
ZmVyZW5jZSBvbiBAZGVudHJ5LCBlLmcuIGluIFJDVSB3YWxrLgotICogVGhlIGV4dGVybmFsIG5h
bWUgb2YgYSBkZWFkIGRlbnRyeSBoYXMgYSB6ZXJvIHJlZmNvdW50IGZvcmV2ZXIsIHNvCi0gKiB0
YWtlX2RlbnRyeV9uYW1lX3NuYXBzaG90KCkgd291bGQgcmV0cnkgd2l0aG91dCBlbmQuICBGYWls
IGluc3RlYWQuCi0gKi8KLWJvb2wgdHJ5X3Rha2VfZGVudHJ5X25hbWVfc25hcHNob3Qoc3RydWN0
IG5hbWVfc25hcHNob3QgKm5hbWUsCi0JCQkJICAgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQotewot
CXJldHVybiBfX3Rha2VfZGVudHJ5X25hbWVfc25hcHNob3QobmFtZSwgZGVudHJ5LCBmYWxzZSk7
Ci19Ci1FWFBPUlRfU1lNQk9MKHRyeV90YWtlX2RlbnRyeV9uYW1lX3NuYXBzaG90KTsKLQogdm9p
ZCByZWxlYXNlX2RlbnRyeV9uYW1lX3NuYXBzaG90KHN0cnVjdCBuYW1lX3NuYXBzaG90ICpuYW1l
KQogewogCWlmICh1bmxpa2VseShuYW1lLT5uYW1lLm5hbWUgIT0gbmFtZS0+aW5saW5lX25hbWUu
c3RyaW5nKSkgewpkaWZmIC0tZ2l0IGEvZnMvb3ZlcmxheWZzL3N1cGVyLmMgYi9mcy9vdmVybGF5
ZnMvc3VwZXIuYwppbmRleCAwODY5NWE5OWY0ZjkzLi5kOTE3NGVhY2NjZTJkIDEwMDY0NAotLS0g
YS9mcy9vdmVybGF5ZnMvc3VwZXIuYworKysgYi9mcy9vdmVybGF5ZnMvc3VwZXIuYwpAQCAtMTAw
LDE3ICsxMDAsMTMgQEAgc3RhdGljIGludCBvdmxfcmV2YWxpZGF0ZV9yZWFsKHN0cnVjdCBkZW50
cnkgKmQsIHVuc2lnbmVkIGludCBmbGFncywgYm9vbCB3ZWFrKQogCQkJZGlyID0gZF9pbm9kZV9y
Y3UocGFyZW50KTsKIAkJCWlmICghZGlyKQogCQkJCXJldHVybiAtRUNISUxEOwotCQkJLyoKLQkJ
CSAqIE5vdGhpbmcgcGlucyBkIGluIFJDVSB3YWxrOiBldmljdGlvbiBvZiB0aGUgb3ZlcmxheQot
CQkJICogaW5vZGUgbWF5IGRyb3AgdGhlIGxhc3QgcmVmZXJlbmNlIGF0IGFueSB0aW1lLgotCQkJ
ICovCi0JCQlpZiAoIXRyeV90YWtlX2RlbnRyeV9uYW1lX3NuYXBzaG90KCZuLCBkKSkKLQkJCQly
ZXR1cm4gLUVDSElMRDsKIAkJfSBlbHNlIHsKIAkJCXBhcmVudCA9IGRnZXRfcGFyZW50KGQpOwog
CQkJZGlyID0gZF9pbm9kZShwYXJlbnQpOwotCQkJdGFrZV9kZW50cnlfbmFtZV9zbmFwc2hvdCgm
biwgZCk7CiAJCX0KKwkJLyogSW4gUkNVIHdhbGsgdGhlIGRlbnRyeSBuYW1lIG1heSBnbyBhd2F5
IGF0IGFueSB0aW1lICovCisJCWlmICghdGFrZV9kZW50cnlfbmFtZV9zbmFwc2hvdCgmbiwgZCkp
CisJCQlyZXR1cm4gLUVDSElMRDsKIAkJcmV0ID0gZC0+ZF9vcC0+ZF9yZXZhbGlkYXRlKGRpciwg
Jm4ubmFtZSwgZCwgZmxhZ3MpOwogCQlyZWxlYXNlX2RlbnRyeV9uYW1lX3NuYXBzaG90KCZuKTsK
IAkJaWYgKCEoZmxhZ3MgJiBMT09LVVBfUkNVKSkKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
ZGNhY2hlLmggYi9pbmNsdWRlL2xpbnV4L2RjYWNoZS5oCmluZGV4IDg0YjBjZmU0ZWQwZTcuLmFh
YTRiYTdhMTI5OTEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZGNhY2hlLmgKKysrIGIvaW5j
bHVkZS9saW51eC9kY2FjaGUuaApAQCAtNjY0LDggKzY2NCw3IEBAIHN0cnVjdCBuYW1lX3NuYXBz
aG90IHsKIAlzdHJ1Y3QgcXN0ciBuYW1lOwogCXVuaW9uIHNob3J0bmFtZV9zdG9yZSBpbmxpbmVf
bmFtZTsKIH07Ci12b2lkIHRha2VfZGVudHJ5X25hbWVfc25hcHNob3Qoc3RydWN0IG5hbWVfc25h
cHNob3QgKiwgc3RydWN0IGRlbnRyeSAqKTsKLWJvb2wgdHJ5X3Rha2VfZGVudHJ5X25hbWVfc25h
cHNob3Qoc3RydWN0IG5hbWVfc25hcHNob3QgKiwgc3RydWN0IGRlbnRyeSAqKTsKK2Jvb2wgdGFr
ZV9kZW50cnlfbmFtZV9zbmFwc2hvdChzdHJ1Y3QgbmFtZV9zbmFwc2hvdCAqLCBzdHJ1Y3QgZGVu
dHJ5ICopOwogdm9pZCByZWxlYXNlX2RlbnRyeV9uYW1lX3NuYXBzaG90KHN0cnVjdCBuYW1lX3Nu
YXBzaG90ICopOwogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBkZW50cnkgKmRfZmlyc3RfY2hpbGQo
Y29uc3Qgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQotLSAKMi41NS4wCgo=
--00000000000092905d065f35a3b4--
