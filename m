Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39725F7B9
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956248; cv=none; b=mWpxT6qxGTM6HH9l70Gl72xvPk223fJfsqn+nAvJHe4P3Cwn9Ewd2uPZUjIj3/tkCJKibhYR1LFZwqRBLpvxkFcz74MVgngf8CRuH3SIhP1RpHLB+NlVWI0HeIvVqSftn0D30nMFQ5aezsvPu2AjByn84yJgmFWtf9F/zgX/HAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956248; c=relaxed/simple;
	bh=m10rYMzicjoeeyxBNG7ZMjKjthtIB+8vTGZfxSQRwHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R85rpR9FcOWorewsncAjt7qEvmFG/SrKq19TncUZZQDwgT5KWGWsk6RZI7duW/eKIPgoxndxp/owSr70Ap/T0r4lZYZ8y0M67B8/MLrXoZIPQd42Anx/Lw9s/VffYsP3pQvZdNE7dSXwvYLtHVyhIeFqxx4isZaRuYiY04ymsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhSMRPoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhSMRPoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3131F00A3D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 01:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782956246;
	bh=wx+So0CEUzPz3bTZgqmttF3XqFgqVlASrmHPrGP/Sds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fhSMRPoIpucrDRSO+3vIBK7Lx4FohucZJXKX7qWjtFoEShGpq5fGbBhOZIo98FIIN
	 JxT5djBGZjQVZ0aGNF2rUsE2bUcPHNvnpPwHA+VAigi+Bmh0T2ZeRYGvEJlKkTDRBJ
	 CF61GmeuEf+3MHGk3C5x+/kpAPZxCtzcWjDIw3o3SaeusjjrnLKnzjvsxp9YBFC1Wf
	 U6x7L7plMdQWw7/hHnjaBA/uytfOd8ije/+vI4uCgIGXQTt4g9aMDfsEj7I92gOCWM
	 oc6jpl0GOgkm0wGUzCg9sA5mJdDBzJq9MHGbQzne4ZYL8xiaPKgB+rLMwodTfOAYsW
	 5s1T2dUoBmAGQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c128c8c7a76so17087066b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 18:37:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpJTw5xOOx0mXb43E0OV7Takd8Bva+AB7Xo0zbWvrSioIeiHj0C+R2F9Fnvq5yVAQWbynrOIPxiHaHpiAr7@vger.kernel.org
X-Gm-Message-State: AOJu0YzDIUwJG0ujx+OroqZKjnFsC/GtM+k8nMmRXNLOwOR12oOCdwoF
	2dugTu2tav5gOwpzFfIaw0jlhFErGOZ8cwe/87SnR7R9PfUpAZqwvc6vblqQgYJ8UuP/qLIaY00
	+kYDnfZz0CblQP8+z12r37LjSCU7EybA=
X-Received: by 2002:a17:907:6d25:b0:c12:7e41:3904 with SMTP id
 a640c23a62f3a-c12a7b4e7d4mr208633266b.16.1782956245496; Wed, 01 Jul 2026
 18:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701221237.822167-1-kudo3228@gmail.com> <CAKYAXd-+EKp98S2WMWNfhX0+fNfq1_3QrdSsnw7uav0hWXdtNg@mail.gmail.com>
In-Reply-To: <CAKYAXd-+EKp98S2WMWNfhX0+fNfq1_3QrdSsnw7uav0hWXdtNg@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 2 Jul 2026 10:37:11 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_zqD8dGrApqpR-ZRvqU1JnVYaXLM9JH2PjJXaekgJgEQ@mail.gmail.com>
X-Gm-Features: AVVi8CfKiOiZSGkFU7ViQwK2-4q1vfTgTCWqtzTnm6vCzx8jxUHbTBHU_ukAvy8
Message-ID: <CAKYAXd_zqD8dGrApqpR-ZRvqU1JnVYaXLM9JH2PjJXaekgJgEQ@mail.gmail.com>
Subject: Re: [BUG/RFC] ntfs: crafted image triggers WARN_ON in ntfs_map_runlist_nolock()
To: =?UTF-8?B?7J207IOB7Zi4?= <kudo3228@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000aa2ddf065596d9a2"

--000000000000aa2ddf065596d9a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 8:36=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.org> =
wrote:
>
> On Thu, Jul 2, 2026 at 7:12=E2=80=AFAM =EC=9D=B4=EC=83=81=ED=98=B8 <kudo3=
228@gmail.com> wrote:
> >
> > Hi,
> Hi Sangho,
> >
> > I found a crafted NTFS image that triggers the following warning during
> > mount-time NTFS logfile handling:
> >
> >   WARNING: fs/ntfs/attrib.c:177 at ntfs_map_runlist_nolock+0x1275/0x17b=
0
> >
> > The observed stack is:
> >
> >   ntfs_map_runlist_nolock
> >   ntfs_empty_logfile
> >   load_system_files
> >   ntfs_fill_super
> >   get_tree_bdev_flags
> >   vfs_get_tree
> >   do_new_mount
> >   __se_sys_mount
> >
> > The warning site is:
> >
> >   fs/ntfs/attrib.c:177
> >   WARN_ON(!ctx->attr->non_resident);
> >
> > The caller path reaches this through:
> >
> >   fs/ntfs/logfile.c:677
> >   err =3D ntfs_map_runlist_nolock(log_ni, vcn, NULL);
> >
> > The current hypothesis is that a malformed image reaches the $LogFile c=
leanup
> > path and causes ntfs_map_runlist_nolock() to find a resident attribute =
where it
> > expects a non-resident one. Since the input is a crafted filesystem ima=
ge, this
> > looks like it should be rejected through an ordinary mount error path r=
ather
> > than tripping a kernel WARN_ON().
> >
> > The crash was found with syzkaller/SyzDirect on a recent local mainline=
 build.
> > syz-repro reproduced the warning during minimization and reduced the sy=
scall
> > sequence to syz_mount_image$ntfs. I also extracted the crashing program=
 from
> > the syzkaller log and generated a standalone C reproducer from it. The =
generated
> > C reproducer compiles locally.
> >
> > I have not yet confirmed whether this has impact beyond a mount-time wa=
rning
> > from a crafted NTFS image. I can provide the full syzkaller/C reproduce=
r and
> > kernel config if useful.
> I will check it and share the patch with you to get your confirmation.
> Thanks.
Please confirm if the attached patch fixes this issue.
thanks!

--000000000000aa2ddf065596d9a2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ntfs-fix-WARN_ON-for-resident-attribute-in-ntfs_map_.patch"
Content-Disposition: attachment; 
	filename="0001-ntfs-fix-WARN_ON-for-resident-attribute-in-ntfs_map_.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mr2u3cov0>
X-Attachment-Id: f_mr2u3cov0

RnJvbSA5OTY5ZjdiNWNiYTI2ZDA0M2IxOWUzNWM0YTk3NTlhZTZjZjdhNTFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBUaHUsIDIgSnVsIDIwMjYgMTA6MzE6NDQgKzA5MDAKU3ViamVjdDogW1BBVENIXSBudGZz
OiBmaXggV0FSTl9PTiBmb3IgcmVzaWRlbnQgYXR0cmlidXRlIGluCiBudGZzX21hcF9ydW5saXN0
X25vbG9jaygpCgpXaGVuIG50ZnNfbWFwX3J1bmxpc3Rfbm9sb2NrKCkgbmVlZHMgdG8gbG9vayB1
cCB0aGUgYXR0cmlidXRlIGV4dGVudApjb250YWluaW5nIGEgdGFyZ2V0IFZDTiAoY3R4X25lZWRz
X3Jlc2V0ID09IHRydWUpLCBpdCBjYWxscwpudGZzX2F0dHJfbG9va3VwKCkgYW5kIHRoZW4gZXhw
ZWN0cyB0aGUgcmVzdWx0IHRvIGJlIGEgbm9uLXJlc2lkZW50CmF0dHJpYnV0ZSwgc2luY2Ugb25s
eSBub24tcmVzaWRlbnQgYXR0cmlidXRlcyBoYXZlIGEgbWFwcGluZyBwYWlycwphcnJheSB0byBk
ZWNvbXByZXNzLgoKQSBjcmFmdGVkIE5URlMgaW1hZ2UgY2FuIHBsYWNlIGEgcmVzaWRlbnQgYXR0
cmlidXRlIHdoZXJlIGEgbm9uLXJlc2lkZW50Cm9uZSBpcyBleHBlY3RlZCwgY2F1c2luZyBudGZz
X2F0dHJfbG9va3VwKCkgdG8gc3VjY2VlZCBidXQgcmV0dXJuIGEKcmVzaWRlbnQgYXR0cmlidXRl
IHJlY29yZC4gIFByZXZpb3VzbHkgdGhpcyB3YXMgY2F1Z2h0IG9ubHkgYnkgYQpXQVJOX09OKCks
IHdoaWNoIGRvZXMgbm90IHN0b3AgZXhlY3V0aW9uLiAgVGhlIGNvZGUgdGhlbiBmYWxscyB0aHJv
dWdoIHRvCnJlYWQgYS0+ZGF0YS5ub25fcmVzaWRlbnQuaGlnaGVzdF92Y24gZnJvbSB3aGF0IGlz
IGFjdHVhbGx5IGEgcmVzaWRlbnQKYXR0cmlidXRlLCBhY2Nlc3NpbmcgdGhlIHdyb25nIHVuaW9u
IG1lbWJlciBhbmQgY29ycnVwdGluZyB0aGUgVkNOIHJhbmdlCmNoZWNrLgoKVGhlIGNhbGxlciBw
YXRoIHRyaWdnZXJpbmcgdGhpcyB3YXJuaW5nIGR1cmluZyBtb3VudCBpczoKCiAgbnRmc19tYXBf
cnVubGlzdF9ub2xvY2sKICBudGZzX2VtcHR5X2xvZ2ZpbGUKICBsb2FkX3N5c3RlbV9maWxlcwog
IG50ZnNfZmlsbF9zdXBlcgoKSW4gdGhpcyBwYXRoIGN0eCBpcyBOVUxMLCBzbyBudGZzX21hcF9y
dW5saXN0X25vbG9jaygpIGFsbG9jYXRlcyBhCnRlbXBvcmFyeSBzZWFyY2ggY29udGV4dCBpbnRl
cm5hbGx5IGFuZCBzZXRzIGN0eF9uZWVkc19yZXNldCA9IHRydWUuClRoZSBleGlzdGluZyByZXNp
ZGVudC1hdHRyaWJ1dGUgZ3VhcmQgaW4gdGhlIGN0eCAhPSBOVUxMIGJyYW5jaCBhbHJlYWR5CnJl
dHVybnMgLUVJTyBzaWxlbnRseSBmb3IgdGhlIHNhbWUgY29uZGl0aW9uOyBtYWtlIHRoZSBjdHhf
bmVlZHNfcmVzZXQKcGF0aCBjb25zaXN0ZW50IGJ5IHJlcGxhY2luZyB0aGUgV0FSTl9PTigpIHdp
dGggdGhlIHNhbWUgLUVJTyBlcnJvcgpyZXR1cm4uCgpUaGlzIGNhdXNlcyB0aGUgY3JhZnRlZCBp
bWFnZSB0byBiZSByZWplY3RlZCB3aXRoIGEgbW91bnQgZXJyb3IgaW5zdGVhZApvZiB0cmlnZ2Vy
aW5nIGEga2VybmVsIHdhcm5pbmcuCgpSZXBvcnRlZC1ieTogU2FuZ2hvIExlZSA8a3VkbzMyMjhA
Z21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwu
b3JnPgotLS0KIGZzL250ZnMvYXR0cmliLmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbnRmcy9hdHRyaWIu
YyBiL2ZzL250ZnMvYXR0cmliLmMKaW5kZXggYTk5Yjg0NzUxZWIxLi5lNWUzYmMwM2FkNDkgMTAw
NjQ0Ci0tLSBhL2ZzL250ZnMvYXR0cmliLmMKKysrIGIvZnMvbnRmcy9hdHRyaWIuYwpAQCAtMTc1
LDcgKzE3NSwxMCBAQCBpbnQgbnRmc19tYXBfcnVubGlzdF9ub2xvY2soc3RydWN0IG50ZnNfaW5v
ZGUgKm5pLCBzNjQgdmNuLCBzdHJ1Y3QgbnRmc19hdHRyX3NlYQogCQkJCWVyciA9IC1FSU87CiAJ
CQlnb3RvIGVycl9vdXQ7CiAJCX0KLQkJV0FSTl9PTighY3R4LT5hdHRyLT5ub25fcmVzaWRlbnQp
OworCQlpZiAodW5saWtlbHkoIWN0eC0+YXR0ci0+bm9uX3Jlc2lkZW50KSkgeworCQkJZXJyID0g
LUVJTzsKKwkJCWdvdG8gZXJyX291dDsKKwkJfQogCX0KIAlhID0gY3R4LT5hdHRyOwogCS8qCi0t
IAoyLjM0LjEKCg==
--000000000000aa2ddf065596d9a2--
