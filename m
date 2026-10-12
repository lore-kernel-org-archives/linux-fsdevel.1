Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4AE3749EF
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811635; cv=pass; b=BVR5aBhSO/LRztYslrNef6K6hmArPJpAF+HBb5u0jCTXHgAcKteX6UvRDLFn/e2I9qIUCas/v1mgaaVcGycoryHKDGF4Uom4Jo8OZjfxxoHJC03ejPTC/a8+glPKh1uzxiqPP7g0acOk5MPZhvaugTYserzG99MT5tLq7SGoFEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811635; c=relaxed/simple;
	bh=H1ij3QKS5qeQ8I9kWjLPeoZQzraYJLNvQBCNmgOu4Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHfyeeM/P/OiOzMelZHEHe++6tdWxX7clSCHSahtXBz2nyFA/iLzJ6A1CBFkkcwTUI9eImo4Y333qyp+POithL0Zu0bsng+hCGvcq7lbgbY7mjP5zf3XOWrBpgOR8SGNfZoUwdiwxlXMQ4m8Zsx29OfuyK6AvXD/ypil2veyIY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCGdAQf0; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCGdAQf0"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so2496356a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 06:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791811631; cv=none;
        d=google.com; s=arc-20260327;
        b=AuWT/NWVRV8WRvJxEeNAaTcJ6Bu9II8Vke/Zl6bgWQu4z6yr71GR99SOawoIKCAMyO
         /xM7vn9xAbS61hJ1WUH7P9meAITiUzdK4eLzUfif/tAStFlltK+SQehDOoWXNSzUxqxm
         gQSWZ828RNAoGyZHnOxZoyNFMqcJw9Afn/FuleRx2V+L39wkggLeq0MgzdHtjJEVq7gy
         CsmdMIh6oxy1oT4jdVTSLWrno4bFw1ezEUDW6Onpg6ommNIPJKU5xiTkdUiZBY+T0u1S
         7Dz1Ioxo14s+0IDFSkMqruDHWnoWMU0zZvYF1R6kHQ+5jZj6AXj1/PedApX1/jnMgOmb
         R+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X/4mrz+vSyH7lWEhdqkYudRoi8+AIdRLYSG2FULjFno=;
        fh=r7z6zaQ1nNB9H8B6V8hcFLixGaOV9nXsSKLqYTHQbCE=;
        b=Anr4LGGBbp/GMFnLV68GaT8VHfRyjJuU6c1BxHN93rES9aKRfflhIzRz0hH9gIGswP
         uRl+nk9Knsq3CADb+hZyZ5+llNSyqPFAnMyTdL7xEqF+z2ZrvIscL4/cG1Dx88WOMcdT
         tAzwIodI+baj4gfF4pNmdSeG/5drFKkzGMSAcvMgF2cdrmv6X+45svai9ZjoUaqGaDuE
         0yhsNo0RTJZnGCMnMaL9x5kuuVXsL7+Mfphp1xZw6IO+M7NAUgCrb/6CIj0TvYulWcAM
         KW410Ce2PjgBmqhKos5mSQdohAbiKSdXt63TdLIjK14o5qq62n+ZsJLC8R4ShwZSBzaQ
         sVwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791811631; x=1792416431; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X/4mrz+vSyH7lWEhdqkYudRoi8+AIdRLYSG2FULjFno=;
        b=cCGdAQf0+3Itjc3MKuxP49XEi7k5GoGBc5Q6YEfIt/FP8tg/3TMyfScM6qmh/JGVhg
         kKvDkG5n/08qS1grGTQFJBURDV2Hd0tAVX9qHZ1bdZe54pdLb7Uoo9t5W3oWmIQBGsY6
         5j0UvYCHVP3gzM9aGsts08uaSr3zFGx0rYA0dMDIiydKKZHIEZSmQQAr6uHAOtG93pG2
         byej2iAOZ2sLbc8Pb05/WBNmkKjDNyRTsLXW/D75VWBPWMBwPGltrKl/HCAv4gx98TCS
         Y2Hm/a8hY1JIiUAKELoLny5PyiB04TScIoIt13LDlxUzelQgYcYoVAlCUmETOsb6QFd4
         SzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791811631; x=1792416431;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X/4mrz+vSyH7lWEhdqkYudRoi8+AIdRLYSG2FULjFno=;
        b=o19lX+SQq2lHfShAgw2+8cUabXbloQNAuXI6JjT2FN+hg6TPWWmLsClC44TtsxRk4X
         qydPh81T1ZwRDVMZRHOou34KpZhHkx7ZMgc19yJmRzNCc7ikmYR++VlcNlZFGC2AjEoO
         KelpR5vmHS+teBWb1Lv9oP+iX8oZq5EmdHNQS5xy7Ca5KgDOtf34w59uIFzelGCdmOEp
         a1UMb6ZGsGVlQaA+nKVES++4XOO3TDLnfGu8qe3AXbDZlUOdAPMB9WX8G2Kw0CMhTc2t
         A5/yEqxigRL/dCLDxKNVbBXfNF77XFzSN83AIwckoX1vxduTuddrh+kEt2eelyip/mrd
         9A7w==
X-Forwarded-Encrypted: i=1; AKwUvBw780wkFU7E7zmYd2yFT3ylKfWVbOs/DN8iE7gbWxkbjq3qosRfBEcsz66IOi2cP9riheB9Zg/ExLFQjjM5@vger.kernel.org
X-Gm-Message-State: AFq9FYJZfd7IBafu3sMy45mapB0QHHeaWu9Anv6GtqD/fJthK/6iKBae
	+sv6WKIG5MrBBmZCNwTTcVYtx6X3ZD5tJTPDOiToVKdYPjH3Togw9X5EVMImoJdG6lCEg/tq8A1
	ANuiFrfmZR73mJVCYn9COjR9X9aY//+Q=
X-Gm-Gg: AYBFou1mLiCRO0CqVfkxclsVyHlBH9jcbB22F6ylVTKiY8sAHJYz4oxvRY2ianLRR5z
	H6zTf1eJTTDKNzFeRCn9DLdvlmePSFgz3bqJY6ZUuMY2tUV1ZgT9OhztIbFIqsCyjF3oDmSZkvv
	Q0Q+NeWWkRN3ic8pmq8ZAmmCf9aQouNKysKNaDXfxJ1TcHhKXSmmrCyFdn2AUWSt+cua4e0OOiO
	Twa9OJP/EsyxdQx5foro+Z0z3wVIJHyf7eiHV544ZuuVDq/M1b7xTgmqxJzSfU0sJBMmFIw2aB4
	wfQElMvEnlk7wB6Vpn1A7u5Hc0S2K+g/B8yfXB5MPKCLFJkcIintgTg7a0nQ53xPkvA=
X-Received: by 2002:a05:6402:27d3:b0:6b1:ceab:697c with SMTP id
 4fb4d7f45d1cf-6b1ceab70fcmr1332114a12.9.1791811631065; Mon, 12 Oct 2026
 06:27:11 -0700 (PDT)
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
 <CAOQ4uxgiub97wtDpWx6n+p4EBuusSp4xKm+b1Xa_GBAHH8=i=g@mail.gmail.com>
In-Reply-To: <CAOQ4uxgiub97wtDpWx6n+p4EBuusSp4xKm+b1Xa_GBAHH8=i=g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 12 Oct 2026 15:26:59 +0200
X-Gm-Features: AclHuK-_0wMMY11ZJYL05XMj1P1Z1SdqBTHar__c-8kEUEzh_zgIFU7OXSwrctk
Message-ID: <CAOQ4uxg7Qt436SiKhKEJKOjtCjeB_XyTjazYF7HMyQAGGcgx2A@mail.gmail.com>
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached connector
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c67580065da4a79a"

--000000000000c67580065da4a79a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 1:48=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Sep 3, 2026 at 3:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > On Wed, Sep 2, 2026 at 11:51=E2=80=AFPM Daehyeon Ko <4ncienth@gmail.com=
> wrote:
> > >
> > > Hi Amir,
> > >
> > > I was able to make the handle-reopen sequence reliable on ext4 and dr=
afted
> > > an LTP test for it.
> > >
> > > The test keeps 120 auxiliary inode marks on the victim to widen the i=
nterval
> > > after the first FAN_DELETE_SELF, pins the unlink and handle-reopen wo=
rkers to
> > > different CPUs, and has the reopen worker read the event queue nonblo=
cking
> > > before calling open_by_handle_at().
> > >
> > > I ran the exact final test for 100 iterations in each of two fresh 2-=
vCPU
> > > KASAN boots per kernel:
> > >
> > >   - unmodified v7.2: 200/200 iterations reopened the unlinked inode, =
and
> > >     closing the reopened fd generated a second FAN_DELETE_SELF;
> > >   - v7.2 with your patch: 200/200 iterations returned ESTALE from
> > >     open_by_handle_at(), with no duplicate FAN_DELETE_SELF.
> > >
> > > The test is based on LTP master commit
> > > 12724413534a6d4160ff9694ba6f09daa4ccb6bd. The attached patch adds
> > > fanotify26 and the corresponding build and runtest entries.
> >
> > Very nice!
> >
> > I think we should wait for Christian to pick up the fix or suggest an
> > alternative, but after that please post this test to LTP.
> >
> > Thanks for following up on this!
>
> Christian,
>
> Please apply this attached patch in-place of 669bb5af15d41 ("fs: make
> sure to call fsnotify_inoderemove() only once when inode is dead") on
> your vfs-7.4.misc branch.
>
> The difference from v1 [1] is removal of the obtain_alias parts, which ar=
e
> wrong for network filesystems.
>
> The LTP test provided by Daehyeon now fails because it uses open_by_handl=
e_at()
> for the reproducer, but a similar race could be created with hardlinks
> release/unlink race and this case should be fixed by this v2, meaning tha=
t
> FS_DELETE_SELF is reported when all hardlinks are unlinked and all
> open files to all hardlinks are closed.

Sorry I forgot to update the comment.
Attached v3 with the comment change.

Thanks,
Amir.

>
> [1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjbEY12XMmfCXTPTpASmECCXc=
GBQR+bS93k=3D4vgqzFDZA@mail.gmail.com/

--000000000000c67580065da4a79a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v3-0001-fs-make-sure-to-call-fsnotify_inoderemove-only-on.patch"
Content-Disposition: attachment; 
	filename="v3-0001-fs-make-sure-to-call-fsnotify_inoderemove-only-on.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mv5abq3o0>
X-Attachment-Id: f_mv5abq3o0

RnJvbSBmZjkxZTEzODQ3YTVkYmVlNGU4NjRhNDdiZTViZjRiY2M4MTk5Yjc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDIgU2VwIDIwMjYgMTg6NDk6MjUgKzAyMDAKU3ViamVjdDogW1BBVENIIHYzXSBm
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
ZXJlbmNlcywgdGhlc2UgZ2FtZXMgd2l0aCBkZWFkIGlub2RlcyBjYW4gZ28gYXMKd2VsbC4KCk5v
dGUgdGhhdCBhIG5ldyBhbGlhcyBjb3VsZCBiZSBjcmVhdGVkIGJ5IG9wZW5fYnlfaGFuZGxlKCkg
dG8gYW4gaW5vZGUKdGhhdCBoYXMgYWxyZWFkeSByZXBvcnRlZCBGU19ERUxFVEVfU0VMRi4gIFRo
aXMgY2FzZSB3aWxsIGJlIGhhbmRsZWQgYnkKYSBkaWZmZXJlbnQgcGF0Y2guCgpSZXBvcnRlZC1i
eTogRGFlaHllb24gS28gPDRuY2llbnRoQGdtYWlsLmNvbT4KQ2xvc2VzOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjYwODI3MDQ1MDA3LjM4MzEyNTktMS00bmNpZW50
aEBnbWFpbC5jb20vCkNDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEFt
aXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ckxpbms6IGh0dHBzOi8vcGF0Y2gubXNn
aWQubGluay8yMDI2MDkwMjE2NDkyNC4xMzMzMTM1LTItamFja0BzdXNlLmN6Ci0tLQogZnMvZGNh
Y2hlLmMgfCAxNCArKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9kY2FjaGUuYyBiL2ZzL2RjYWNoZS5j
CmluZGV4IGI4OWM4NDgwYjY1NWIuLjg2YTNhMDA5MjlkZTEgMTAwNjQ0Ci0tLSBhL2ZzL2RjYWNo
ZS5jCisrKyBiL2ZzL2RjYWNoZS5jCkBAIC00NTAsNiArNDUwLDE2IEBAIHN0YXRpYyB2b2lkIGRl
bnRyeV9mcmVlKHN0cnVjdCBkZW50cnkgKmRlbnRyeSkKIAkJY2FsbF9yY3UoJmRlbnRyeS0+ZF9y
Y3UsIF9fZF9mcmVlKTsKIH0KIAorLyoKKyAqIFdoZW4gaW5vZGUgaXMgdW5saW5rZWQgYW5kIGRv
ZXNuJ3QgaGF2ZSBhbnkgYWxpYXNlcyAoaS5lLiwgYWxsIGZkcyBwb2ludGluZworICogdG8gaXQg
YXJlIGNsb3NlZCkgd2UgcmVwb3J0IEZTX0RFTEVURV9TRUxGIHRvIGZzbm90aWZ5IGFuZCBjbGVh
bnVwIGFsbCBpbm9kZQorICogbWFya3MuCisgKi8KK3N0YXRpYyBib29sIGlub2RlX25vdGlmeV9k
ZWFkKHN0cnVjdCBpbm9kZSAqaW5vZGUpCit7CisJcmV0dXJuICFpbm9kZS0+aV9ubGluayAmJiBo
bGlzdF9lbXB0eSgmaW5vZGUtPmlfZGVudHJ5KTsKK30KKwogLyoKICAqIFJlbGVhc2UgdGhlIGRl
bnRyeSdzIGlub2RlLCB1c2luZyB0aGUgZmlsZXN5c3RlbQogICogZF9pcHV0KCkgb3BlcmF0aW9u
IGlmIGRlZmluZWQuCkBAIC00NTksNiArNDY5LDcgQEAgc3RhdGljIHZvaWQgZGVudHJ5X3VubGlu
a19pbm9kZShzdHJ1Y3QgZGVudHJ5ICogZGVudHJ5KQogCV9fcmVsZWFzZXMoZGVudHJ5LT5kX2lu
b2RlLT5pX2xvY2spCiB7CiAJc3RydWN0IGlub2RlICppbm9kZSA9IGRlbnRyeS0+ZF9pbm9kZTsK
Kwlib29sIG5vdGlmeV9kZWFkOwogCiAJcmF3X3dyaXRlX3NlcWNvdW50X2JlZ2luKCZkZW50cnkt
PmRfc2VxKTsKIAlfX2RfY2xlYXJfdHlwZV9hbmRfaW5vZGUoZGVudHJ5KTsKQEAgLTQ2OSw5ICs0
ODAsMTAgQEAgc3RhdGljIHZvaWQgZGVudHJ5X3VubGlua19pbm9kZShzdHJ1Y3QgZGVudHJ5ICog
ZGVudHJ5KQogCSAqLwogCWRlbnRyeS0+d2FpdGVycyA9IE5VTEw7CiAJcmF3X3dyaXRlX3NlcWNv
dW50X2VuZCgmZGVudHJ5LT5kX3NlcSk7CisJbm90aWZ5X2RlYWQgPSBpbm9kZV9ub3RpZnlfZGVh
ZChpbm9kZSk7CiAJc3Bpbl91bmxvY2soJmRlbnRyeS0+ZF9sb2NrKTsKIAlzcGluX3VubG9jaygm
aW5vZGUtPmlfbG9jayk7Ci0JaWYgKCFpbm9kZS0+aV9ubGluaykKKwlpZiAobm90aWZ5X2RlYWQp
CiAJCWZzbm90aWZ5X2lub2RlcmVtb3ZlKGlub2RlKTsKIAlpZiAoZGVudHJ5LT5kX29wICYmIGRl
bnRyeS0+ZF9vcC0+ZF9pcHV0KQogCQlkZW50cnktPmRfb3AtPmRfaXB1dChkZW50cnksIGlub2Rl
KTsKLS0gCjIuNTUuMAoK
--000000000000c67580065da4a79a--
