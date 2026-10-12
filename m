Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770248C403
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805719; cv=pass; b=PGw2NhInlgxSqbK4s/aOxjU8p7+aYa2K4siXZKqwsSYfnUmniLvBh6cRnGvTUzBqS9UtfAZBnMEXJhXz81iDMjTFgfu8J3tHcLR2vcKO/vphkpfN+UKOUgfGF5R8fYSevRonqyN9rris/XeEOlJUNZz5gQKfBZYwl7LGdImaA7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805719; c=relaxed/simple;
	bh=bHkz39C6OrzERAVDJyiFo9xxxGDRCPcbH9z/u7ANPYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI5N0A9mTUF32KniskBlNhCpiFEmWAv/pv8DyqB7wn9wbxRh+vM1fv/9/dNkXfjyb5UhNRctvWxLMeY1Bp/fZzyeHknQYh96GVgDlrCwV/ihg1r/9FdjEQTM7818w9ndL6X8rXruiPz4pZOQ2xVfUJzDywQLgJlviXXBstLkBio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV4+KSwH; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV4+KSwH"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1af232df4so976990a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 04:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791805712; cv=none;
        d=google.com; s=arc-20260327;
        b=sUt+lT9xFtIuwWJgARBUusQBWkcGw1jgTIx7ddDeGFX4voC5BsRjIoS7NcwqpytBux
         fGXI10US5FV9Dj6hSqMX1hSAjRnXb3zQt5KGk5h7pokppFCTN907IWRJtdogeCwVS2ut
         DyRYJD+li9HfEv89gXDkZ0jBVC+KM6wDygL3cBmEUDIZu1N0jk1xzKbTmaLjnjunbpiQ
         BB721mpToURZjNiSh29BtysFV4kTgPGGwgGO5dChskSRaeffqHmvWPRkdEUlyBq3QjQw
         irFswjppZchWUkTcGIQ3DSLO95Ixl6EKYdUEpvSgfUMnzIkgKQryavBd09Mj+tTtH+uS
         4sMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lmsFEeC/ekTgEW6pV7DGJPlclpAAgkthwTnO9vJfkbU=;
        fh=PGjPptgsyuoorjO/Q1UtBUplt0L10wUkQfTE7NjPOn0=;
        b=myAGGPxbrmHMsY7QQ0sxHDzEsOZ0iphVvcHKxpUHWttk/Y8sbmjxQrj6XQElIZBjgO
         R8G7Gs8pYT3LxqChRo0KOpbfTPf0NKRUFP+5PyqKzy1NirFeaKnVjlZvBnlf0Jgq+hLG
         RaTuF5a5ASGNXjO8OgvtK19AxKP56rdU757mj02tvWYeH3pp19DuJmmDE9EebdrtHHao
         cQpOeLrXbXv8Ampp2gbEMA+xHGMB/EKYlMy9yENaPXizXR5wLI6NZHAn6+kxaPyVIa6L
         WsnBdJ77OyuQbov4oUI5uimcfH56uBRQABIThfx2aE9SFyBCr7FUlLfjvKlIUlfGjHQq
         WVcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791805712; x=1792410512; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmsFEeC/ekTgEW6pV7DGJPlclpAAgkthwTnO9vJfkbU=;
        b=HV4+KSwHEwal6ltafR4scguVC5yUNOYUhjxW501cQ2GyO5Rwu90uXish4IlzfQQKTL
         x2yltS2jw3OfeyrWwsFFGIaZqxRIDgP39B/wDMLkV4oQsoSc4IcFjI1gHHvGGXlbSOyw
         AFmd9GCe0DlWILjYBvXWv1KPtFQOAG17WpX9kbItb4z4rSPTyovPzvIjsJXiGADEa9Es
         T2PLY4WGDNp3I3yadpJG+LeuxmkrZ/YH6dFTVSvb+kHlbASo4P2IgihCZ/+q1LPvX9lN
         2xb+y3DPrSf/6z2NplGP8aVqwUpIqGsKmO8PGwni/py+phYEgI4gb+48AVjnuYbRZbqG
         jnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805712; x=1792410512;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lmsFEeC/ekTgEW6pV7DGJPlclpAAgkthwTnO9vJfkbU=;
        b=tp+WAcYK8OrQed8iLNSJ5bvQUK/5hS/4wj9Yv1YoG1nPPV2BBuHo/fU82wpyBfWd7O
         y8TzPcKKao3PKKPkQ7eGDaB8xARN1TdeMSrfwGMnpFQUQQLRv2NrfgbDJwvl6vVUiTdP
         yXs9CEE/PPR0WCAwwArPl7kBrpBFubXRYHDmlWlIThUI0zvHdZLugG1Ys0Fmrb15LGCK
         QyzRQKOrgd39PbV1msJLZP4SPAhUhW2V+AWzNTVsJCQPurnRU0w0Wh+xmsp+NrQ9nVKi
         UHixeTmJNZS32kVhmUpFuMGjEY9E0IeKN9+08loSPHBgqo4aQBmVyDOfE/59gc+N03Iu
         r7ng==
X-Forwarded-Encrypted: i=1; AKwUvByn4LDUx+VDDrYrW9dpD8zmry5WyXM9hDbm0STBf+26uvMxqpXuhyFEyBHlr/L92zNA4Wk2LJsTLSrSy+wl@vger.kernel.org
X-Gm-Message-State: AFq9FYJSKzOVkE+00Kv8UfCIACxb7uO7ru+jm6ei/mdjHPKQJNRKb4Mr
	mX9UlhSKbykiI4cTB3bgkUz71s0oURxv79JDVlccsmU/DaSGg7SiXkWTt4oH1p0LD0rC29jjZEo
	E+LdE4KouZTUBHcW4e9RFWInXNr99JUM=
X-Gm-Gg: AYBFou3STaQ55ovfNw/stSV4CQY59q0fvbMqYwc6XEaTrZg4/8c8JEAxvBiGHpwv1cY
	B4DNH5q/KJPqB2Ss2SzJUeQTccGmUykT4oxB+Rv5KXxUgSO3HEN3yMzhqdWAeGCoDzIC4Eh8U6O
	a19PVT5hVrQDHpofMiUej0A4FXoXTu7jgRVR76JCXyvK4TwlT+QVnc8NZleCwZZA44TdK48iaHI
	dgNms6G54yvvsfemTXVn/I5pqk8x+szuy2b7TS3cFit1U99fEunhsFkIvtEX8pIY/f+zStZZMo8
	u4UTJVg4Vg22hhb4Um843Mrek1bKSSKF3mQs0fEzXJ51vUOR9tMad+5M
X-Received: by 2002:a17:907:c317:b0:c2e:62af:b6f3 with SMTP id
 a640c23a62f3a-c31a9afb29amr868480266b.15.1791805712022; Mon, 12 Oct 2026
 04:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827045007.3831259-1-4ncienth@gmail.com> <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
 <20260828042421.964822-1-4ncienth@gmail.com> <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak>
 <CAOQ4uxgB9anyJcWem04w65VCJdxbbb2cQDZ_u8qMusw3xpB9Gw@mail.gmail.com>
 <63aj7jbfaoamdmcurlge2c2kqpliaifgq4vbythrrxpfyr5vtm@z64myom426zd>
 <CAOQ4uxh-NZ76hEFoNNGjyhodr9U=dvZuGVmYHVPGZ_=jRxCAsA@mail.gmail.com>
 <67hq7zqnvp6onwwjp24axucgxbzsko2dphielupdfzmfyk6x57@bdeef7fjkqfa>
 <CAOQ4uxiQF4M_YSBMW3h8VCKR15GV6g_K5nf=2odtYetEwKHm9A@mail.gmail.com>
 <6n6r5zvcu5ojihyb52rhejlky7xrn2a2p4l2cgfut5lsscunek@bcnpy7bifjrs>
 <CAOQ4uxjbEY12XMmfCXTPTpASmECCXcGBQR+bS93k=4vgqzFDZA@mail.gmail.com>
 <20260902070359.4163607-1-4ncienth@gmail.com> <CAOQ4uxjwGdKhX423KoFxW+T5hc9uzCWSsGwn0-QX=CJipPSaYQ@mail.gmail.com>
 <20260902215046.1149198-1-4ncienth@gmail.com> <CAOQ4uxhuOSyMHnj9JZk6LU9=wpE=BRFXJ3fSEOGGV+6tC_5hfg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhuOSyMHnj9JZk6LU9=wpE=BRFXJ3fSEOGGV+6tC_5hfg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 12 Oct 2026 13:48:20 +0200
X-Gm-Features: AclHuK_C782DszumvhqYNB4Lzlz2khgPwhv7ZQZ8fV6lkZD2tOoCinEhNUVm6hs
Message-ID: <CAOQ4uxgiub97wtDpWx6n+p4EBuusSp4xKm+b1Xa_GBAHH8=i=g@mail.gmail.com>
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached connector
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f903a5065da346d8"

--000000000000f903a5065da346d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 3:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Wed, Sep 2, 2026 at 11:51=E2=80=AFPM Daehyeon Ko <4ncienth@gmail.com> =
wrote:
> >
> > Hi Amir,
> >
> > I was able to make the handle-reopen sequence reliable on ext4 and draf=
ted
> > an LTP test for it.
> >
> > The test keeps 120 auxiliary inode marks on the victim to widen the int=
erval
> > after the first FAN_DELETE_SELF, pins the unlink and handle-reopen work=
ers to
> > different CPUs, and has the reopen worker read the event queue nonblock=
ing
> > before calling open_by_handle_at().
> >
> > I ran the exact final test for 100 iterations in each of two fresh 2-vC=
PU
> > KASAN boots per kernel:
> >
> >   - unmodified v7.2: 200/200 iterations reopened the unlinked inode, an=
d
> >     closing the reopened fd generated a second FAN_DELETE_SELF;
> >   - v7.2 with your patch: 200/200 iterations returned ESTALE from
> >     open_by_handle_at(), with no duplicate FAN_DELETE_SELF.
> >
> > The test is based on LTP master commit
> > 12724413534a6d4160ff9694ba6f09daa4ccb6bd. The attached patch adds
> > fanotify26 and the corresponding build and runtest entries.
>
> Very nice!
>
> I think we should wait for Christian to pick up the fix or suggest an
> alternative, but after that please post this test to LTP.
>
> Thanks for following up on this!

Christian,

Please apply this attached patch in-place of 669bb5af15d41 ("fs: make
sure to call fsnotify_inoderemove() only once when inode is dead") on
your vfs-7.4.misc branch.

The difference from v1 [1] is removal of the obtain_alias parts, which are
wrong for network filesystems.

The LTP test provided by Daehyeon now fails because it uses open_by_handle_=
at()
for the reproducer, but a similar race could be created with hardlinks
release/unlink race and this case should be fixed by this v2, meaning that
FS_DELETE_SELF is reported when all hardlinks are unlinked and all
open files to all hardlinks are closed.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjbEY12XMmfCXTPTpASmECCXcGB=
QR+bS93k=3D4vgqzFDZA@mail.gmail.com/

--000000000000f903a5065da346d8
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v2-0001-fs-make-sure-to-call-fsnotify_inoderemove-only-on.patch"
Content-Disposition: attachment; 
	filename="v2-0001-fs-make-sure-to-call-fsnotify_inoderemove-only-on.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mv56k4nm0>
X-Attachment-Id: f_mv56k4nm0

RnJvbSAzMmZjOWFiNzdhMTI4MGVlODAzOTlkMTczYTY2MWVmOGM1MDcxM2ViIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDIgU2VwIDIwMjYgMTg6NDk6MjUgKzAyMDAKU3ViamVjdDogW1BBVENIIHYyXSBm
czogbWFrZSBzdXJlIHRvIGNhbGwgZnNub3RpZnlfaW5vZGVyZW1vdmUoKSBvbmx5IG9uY2UKIHdo
ZW4gaW5vZGUgaXMgZGVhZAoKRGFlaHllb24gcmVwb3J0ZWQgYSByYWNlIHdoZXJlaW4gZnNub3Rp
ZnlfcmVtb3ZlaW5vZGUoKSBjYW4gYmUgY2FsbGVkCndoZW4gaW5vZGUgc3RpbGwgaGFzIGEgbGl2
ZSBhbGlhcy4gIFRoaXMgY2FuIGxlYWQgdG8gc2V2ZXJhbCB1bmRlc2lyZWQKb3V0Y29tZXMgc3Vj
aCBhcyBjcmFzaGVzIGluIGZzbm90aWZ5IGNvZGUgb3IgYXZvaWRhbmNlIG9mIGlub2RlIG1hcmsK
bm90aWZpY2F0aW9ucy4KCkNoZWNrIHRoYXQgaW5vZGUgaXMgcmVhbGx5ICJkZWFkIiwgbWVhbmlu
ZyBubyBubGluayBhbmQgbm8gbW9yZSBhbGlhc2VzCmJlZm9yZSBjYWxsaW5nIGZzbm90aWZ5X2lu
b2RlcmVtb3ZlKCkgZm9yIGZpbmFsIGNsZWFudXAgb2YgaW5vZGUgbWFya3MuCgpJZGVhbGx5LCB3
ZSdkIGNhbGwgZnNub3RpZnlfaW5vZGVyZW1vdmUoKSBvbmNlIGxhc3QgaW5vZGUgcmVmZXJlbmNl
IGlzCmRyb3BwZWQgdG8gbWFrZSB0aGluZ3Mgc2ltcGxlci4gQWxhcyBmc25vdGlmeSBpbm9kZSBt
YXJrcyBjdXJyZW50bHkgaG9sZAppbm9kZSByZWZlcmVuY2VzIGFuZCB0aHVzIHRoaXMgZG9lc24n
dCB3b3JrLiBPbmNlIHdlIHRlYWNoIGZzbm90aWZ5IHRvCmF2b2lkIGhvbGRpbmcgaW5vZGUgcmVm
ZXJlbmNlcywgdGhlc2UgZ2FtZXMgd2l0aCBkZWFkIGlub2RlcyBjYW4gZ28gYXMKd2VsbC4KClJl
cG9ydGVkLWFuZC10ZXN0ZWQtYnk6IERhZWh5ZW9uIEtvIDw0bmNpZW50aEBnbWFpbC5jb20+CkNs
b3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZnNkZXZlbC8yMDI2MDgyNzA0NTAw
Ny4zODMxMjU5LTEtNG5jaWVudGhAZ21haWwuY29tLwpDQzogc3RhYmxlQHZnZXIua2VybmVsLm9y
ZwpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBKYW4gS2FyYSA8amFja0BzdXNlLmN6PgpMaW5rOiBodHRwczovL3BhdGNoLm1z
Z2lkLmxpbmsvMjAyNjA5MDIxNjQ5MjQuMTMzMzEzNS0yLWphY2tAc3VzZS5jegpTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gQnJhdW5lciAoQW11dGFibGUpIDxicmF1bmVyQGtlcm5lbC5vcmc+Ci0t
LQogZnMvZGNhY2hlLmMgfCAxNSArKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZGNhY2hlLmMgYi9m
cy9kY2FjaGUuYwppbmRleCBiODljODQ4MGI2NTViLi41MmZjZDA2NDZkMGVkIDEwMDY0NAotLS0g
YS9mcy9kY2FjaGUuYworKysgYi9mcy9kY2FjaGUuYwpAQCAtNDUwLDYgKzQ1MCwxNyBAQCBzdGF0
aWMgdm9pZCBkZW50cnlfZnJlZShzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpCiAJCWNhbGxfcmN1KCZk
ZW50cnktPmRfcmN1LCBfX2RfZnJlZSk7CiB9CiAKKy8qCisgKiBJZiBpbm9kZSBpcyB1bmxpbmtl
ZCBhbmQgZG9lc24ndCBoYXZlIGFueSBhbGlhc2VzIChpLmUuLCBhbGwgZmRzIHBvaW50aW5nIHRv
CisgKiBpdCBhcmUgY2xvc2VkKSwgaXQgaXMgcHJldHR5IG11Y2ggZGVhZC4gRXhjZXB0IHRoYXQg
ZmlsZSBoYW5kbGUgbG9va3VwIGNvdWxkCisgKiBzdGlsbCByZXZpdmUgaXQgd2hpY2ggY2F1c2Vz
IGlzc3VlcyB0byBmc25vdGlmeS4gU28gb25jZSBpbm9kZSByZWFjaGVzIHRoaXMKKyAqIHN0YXRl
IHdlIG1ha2Ugc3VyZSB0byBibG9jayBjcmVhdGluZyBhbnkgbmV3IGFsaWFzZXMuCisgKi8KK3N0
YXRpYyBib29sIGlub2RlX25vdGlmeV9kZWFkKHN0cnVjdCBpbm9kZSAqaW5vZGUpCit7CisJcmV0
dXJuICFpbm9kZS0+aV9ubGluayAmJiBobGlzdF9lbXB0eSgmaW5vZGUtPmlfZGVudHJ5KTsKK30K
KwogLyoKICAqIFJlbGVhc2UgdGhlIGRlbnRyeSdzIGlub2RlLCB1c2luZyB0aGUgZmlsZXN5c3Rl
bQogICogZF9pcHV0KCkgb3BlcmF0aW9uIGlmIGRlZmluZWQuCkBAIC00NTksNiArNDcwLDcgQEAg
c3RhdGljIHZvaWQgZGVudHJ5X3VubGlua19pbm9kZShzdHJ1Y3QgZGVudHJ5ICogZGVudHJ5KQog
CV9fcmVsZWFzZXMoZGVudHJ5LT5kX2lub2RlLT5pX2xvY2spCiB7CiAJc3RydWN0IGlub2RlICpp
bm9kZSA9IGRlbnRyeS0+ZF9pbm9kZTsKKwlib29sIG5vdGlmeV9kZWFkOwogCiAJcmF3X3dyaXRl
X3NlcWNvdW50X2JlZ2luKCZkZW50cnktPmRfc2VxKTsKIAlfX2RfY2xlYXJfdHlwZV9hbmRfaW5v
ZGUoZGVudHJ5KTsKQEAgLTQ2OSw5ICs0ODEsMTAgQEAgc3RhdGljIHZvaWQgZGVudHJ5X3VubGlu
a19pbm9kZShzdHJ1Y3QgZGVudHJ5ICogZGVudHJ5KQogCSAqLwogCWRlbnRyeS0+d2FpdGVycyA9
IE5VTEw7CiAJcmF3X3dyaXRlX3NlcWNvdW50X2VuZCgmZGVudHJ5LT5kX3NlcSk7CisJbm90aWZ5
X2RlYWQgPSBpbm9kZV9ub3RpZnlfZGVhZChpbm9kZSk7CiAJc3Bpbl91bmxvY2soJmRlbnRyeS0+
ZF9sb2NrKTsKIAlzcGluX3VubG9jaygmaW5vZGUtPmlfbG9jayk7Ci0JaWYgKCFpbm9kZS0+aV9u
bGluaykKKwlpZiAobm90aWZ5X2RlYWQpCiAJCWZzbm90aWZ5X2lub2RlcmVtb3ZlKGlub2RlKTsK
IAlpZiAoZGVudHJ5LT5kX29wICYmIGRlbnRyeS0+ZF9vcC0+ZF9pcHV0KQogCQlkZW50cnktPmRf
b3AtPmRfaXB1dChkZW50cnksIGlub2RlKTsKLS0gCjIuNTUuMAoK
--000000000000f903a5065da346d8--
