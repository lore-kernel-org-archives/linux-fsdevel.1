Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795196594;
	b=03cPN9d/ZrkJDSdAlaNW8VioKkN/a1K1PrzP74ZMNPpY6mpS8gm+et7D9mZc5wDT9LuH
	 Ny383orqV3TqkPUEORszGS8rehynJcyTCtDgzLYCtK/8w1pYtBQ2H2fMyAISKs/oBoxOB
	 Ea4FGPtQbHe1uTyZLyyKk4MoEAliuYGXfXNtNmNuRjUkkjoJkuIBJYNNtvoza/BDWNQ9L
	 zMvzBQd/uyRlxz3AO4xauNvngVFSR/WSeZ996Ruf+gtUWtIuws9Eqq3MUcML9JtmcgCnF
	 c75mJK9+5DkpK3DeY1f2xadwaOeKBqtTPdfFySmc5AkDqsUquAvnP0FW1RYVNcGwDgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+eVDT9v3+iD0V0mnWpMl7xF2rJBa2VX83LNnyl+IZP8=;
	b=LnLkefdire0t48RW3OlWlBrnWAZFvcK15VL/ZSHy8SfNLAB+okXhqeMt4jQNeEpAuygU
	 m9752AOH27L5zyf/QWcJVe2tvYaq5RHoC0V2YEgoZMyKtTRglNx9nF3L9vD6hrRYLISuk
	 yfGRWK28C5P9nQZp1C3b8wlCdo26f+5wWhdrpCH0+jkqWG9OQrHutjrR1cd52kdHwy+jc
	 1vQfiQki4JKfNTNqxfCDhTjC/D6THTJQw5fku1XUJ4Lu/k5mI3yeueCoBNckEKVsBuwGt
	 AaK9cV3Vex+E1FC2Ivq7Yp3LbQxQWad3DH3PLh4PAwyj2mmw74SKAL/hqQFMgO+FL+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nPvAXc9t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867E606A334
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 17:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D867E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nPvAXc9t
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso1535262a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 09:43:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795196592; cv=none;
        d=google.com; s=arc-20260327;
        b=kHCQcoX+IhUnUHPvXJEeule9Xz3mx923m0wof3csvQl/QkhqvhVor7IAGybV+Z+mtx
         33wjk8Z8HOIvTP+3BkPnxisek6HHxVd98bSBrHwo/aNOhnpYawgvD+kZx3//mmvLcBJg
         QB6ekhEfMlebSJ1xA/K+IBtI6XvdXYB61vWpiagacDEUPbwLuf6rMvARXvV5HZd/THPN
         uavJuUM77jkd71qI3VA5r5O+pbPQI4yasONAbePzp1o+bEtGMuovAnBYazKpKLODL5oX
         YSoNNnNmcd+SUi2ZbcUCJSeNtHNE2owLQDUUsKDrZ/lB/8HVg+dCDRr8b0Y7a0Ck57dW
         9Hng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+eVDT9v3+iD0V0mnWpMl7xF2rJBa2VX83LNnyl+IZP8=;
        fh=RxbujokTKdFQ7eFPhJCs0cGTSfr0cly2DJ0p5RpvGRs=;
        b=ivdMXiGgTB8FG4N30L3JlaemjviX4Zl3JdaSTUsi4PLZQ+kiCtE7ya/XCA9Q3UQPEG
         ToMUxA2GSdxMDI/VNLCf1mGRQDO5EzPCh4NV3mhNo6JT9ltQZG+QuavFu98qfBgwG78f
         //bkyWeslGjmSz8Z7m+RLF2cUrNBF1M3cP/tTtThg/1DDc9AOs2SODVkDo0D0FhMVonY
         8izStEEjVZAQUaPPC6u12wUuyMUpE4AlpaRYJvHCqp12PeTDhpb9+HqjsxiW72EQ5j8r
         wV3od8eGXScvfzHXlzVoks/TeCtNpY2DPehq7WWO94xrQdXUvyqPTsglXspBJmHObUTx
         LYlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795196592; x=1795801392; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+eVDT9v3+iD0V0mnWpMl7xF2rJBa2VX83LNnyl+IZP8=;
        b=nPvAXc9t3D0dsgPCV12g2isXS55rnYh+TtvjZtuo5hrQNfoNNi/unJlXGtgWSpzY8F
         z5NiN3hbulBJH6Q/Ji3iwtQ1GjhMamQPFXQ6UeGUA1x3Deiep2LpUKn6JlHqr8CW4f0v
         dYpZ3/MqKnGY/Bw2miV3B9NUqFaStHQAGIc3KQEHnfkzv9EODDxaR1oQnDVrEJkp9ULJ
         +O5/eTtqJ/+7RCoMUb+yVkTGnZ9RXrEk0lpA7iFyCls4q/23ir467+chNX0Of6Igy1w5
         w4ruNCbyte/beP+egkBppWporqkRxTTwCKDB8OVQXGKSg1hIF+4i70wWRU4mh7CImS1x
         PcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196592; x=1795801392;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+eVDT9v3+iD0V0mnWpMl7xF2rJBa2VX83LNnyl+IZP8=;
        b=sgQYQtghJoK7cz04YhYLdNHwcFV8Rm5tqmW5ACpks5UMsazE/YuJC+1IfH+ZzYsQEo
         boZ4DPeeU6a6oA4he6tWFq26GzGasctUZ6jyL65dd65CjqkQZq6M+FTFHloS0fuZoXRN
         2aWi7TqinNs0oINjSJglP/Am/rqqTdcb0tcHqd8lIo/HM9Tb3pIiy7EbprUtOAPVIs7U
         iMxV932TPKwkrCxksLgvDV9zJSejime2bM3PQG9aWwkR68I7uTJte7JMRZVbc72KQt0R
         UB4prC47JuKsTOWL0+F3wbLcG2v1nhR+Lcegl4phIJJAEOLSqKTi32kFvb1ZzpELNLcf
         NIPg==
X-Forwarded-Encrypted: i=1; AL+hErHGOlIxQO+Y753gIQSUOH+WNdFJ2nKYtAHcOFe4bmd4fU4KyxLpySLET1IiCOvK8BmyEEm1XXOFbnEUUJch@vger.kernel.org
X-Gm-Message-State: APuU4Z8w4ZHW5Et/84X2iFcLLTms9b+nIbixwPjWmxsZ2xWlSfUgyrJl
	P4tZlHETVNj6LxGLzaBsPe1IoO1eJouiUd3RR7Ji/LgQuoReOiWNOnIiEiypqP/WScXeL1PLXfb
	dRLjPqauAi+eZA2G+EVYDP36xo//crKg=
X-Gm-Gg: AZFdTZeYFSUByx7s0/SpPhQ1Q1NnYUloU3LoYUmHhOjKVoqzDtpCw49c1mjiy+VyEyA
	W/aaTB/4vvY4OBkzLOjE8VWdsa/0wwwdYQqx7y041zCJDbd2a30jaa2Y1dkX6tlb+FFxoI55K8r
	cPSVrQMOhyEnqTUZU4xnW+m4SOsHFqv//NiVg+NjfrGvm1MDatdey3/wMU9g6x7E13BdF0VpCwO
	bVWeuo8C+OXELkRffgZ/zmNl8DzT0dqH9Viouf3N5enN1agcliR9UabL2dRrb0+QLWZ8pOgt0O4
	ktrIPRXvKm3/vBh3IulEcfy5z96Gz2eQBE8U5Y0sW2iDKvrOLf3f73kMQi2N5GDaE5lVJYUnjNN
	f2d5L4hB6t6SUm3iPQ0JEgU/4AsQdLlyPh/+IxGHqIAGkeMCxdW2I+K94A9c77K5pHtaNVQ==
X-Received: by 2002:a05:6402:51a:b0:6b7:c9d3:f3d with SMTP id
 4fb4d7f45d1cf-6ba37d606c8mr2501478a12.15.1795196592035; Fri, 20 Nov 2026
 09:43:12 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119025942.2848130-1-neilb@ownmail.net> <20261119025942.2848130-3-neilb@ownmail.net>
 <mk7u4brorzgbyol7x4nyolufk3s3piqwqd5hnya3nhoq43d5ui@x5sdqeyrhde6> <CAOQ4uxgEqDiw2=dCM_PV9kObBboCmt7ohnHehKR8cgKyvLTPUw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgEqDiw2=dCM_PV9kObBboCmt7ohnHehKR8cgKyvLTPUw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Nov 2026 18:42:59 +0100
X-Gm-Features: Aa3M54q4VpEsU-ozYBQ4fcI0FEV5aArEyGhNJhnRkyCu5MjhVI-jJJsyiJ1pQkU
Message-ID: <CAOQ4uxjpLOmESHfkTRGziY-MuFvhD5B_Ay3dxZLLbsr2KafUvw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] fsnotify: update children flags only when adding
 mask bits
To: Jan Kara <jack@suse.cz>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, Jake Edge <jake@lwn.net>
Content-Type: multipart/mixed; boundary="0000000000002bd0fa0660b8c756"

--0000000000002bd0fa0660b8c756
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 1:43=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Nov 20, 2026 at 10:48=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 19-11-26 13:57:02, NeilBrown wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Since we only ever set the PARENT_WATCHED flag from
> > > fsnotify_recalc_mask(), there is never a need to update children flag=
s
> > > when removing mark mask bits only when adding them.
> > >
> > > Add a helper fsnotify_recalc_mask_and_update_children() to be called
> > > in cases where updating children flags may be needed (i.e. add mark).
> > >
> > > Also avoid update children walk with mark spinlock held.
> > > This was only done by dnotify and can be easily avoided.
> > >
> > > neilb: added update_children flag in fcntl_dirnotify() so we only
> > >   do the update when needed.
> > >
> > > Fixes: 172e422ffea20 ("fsnotify: clear PARENT_WATCHED flags lazily")
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: NeilBrown <neil@brown.name>
> >
> > One question to Amir below. Otherwise I like it.
> >
> > > +/*
> > > + * Recalculate mask and update children dentry PARENT_WATCHED flags =
if the
> > > + * connector started watching children.  When parent stops watching,=
 we
> > > + * clear false positive PARENT_WATCHED flags lazily in __fsnotify_pa=
rent().
> > > + *
> > > + * The caller must make sure connector and connector->obj cannot dis=
appear
> > > + * under us.  This is achieved by holding mark->group->mark_mutex fo=
r a
> > > + * mark on this list.  mark->lock must not be held by the caller.
> > > + */
> > > +void fsnotify_recalc_mask_and_update_children(
> > > +                                     struct fsnotify_mark_connector =
*conn)
> > > +{
> > > +     if (fsnotify_recalc_mask(conn))
> > >               fsnotify_conn_set_children_dentry_flags(conn);
> > >  }
> > >
> > > @@ -367,8 +383,8 @@ void fsnotify_modify_mark_mask(struct fsnotify_ma=
rk *mark, u32 set, u32 clear)
> > >               recalc =3D true;
> > >       spin_unlock(&mark->lock);
> > >
> > > -     if (recalc)
> > > -             fsnotify_recalc_mask(mark->connector);
> > > +     if (recalc && fsnotify_recalc_mask(mark->connector) && set)
> >
> > Amir, why is the '&& set' check here? Under normal circumstances if
> > fsnotify_recalc_mask() return's true, 'set' is true as well. We can be
> > racing with other updates to the connector list of marks and in that ca=
se our
> > fsnotify_recalc_mask() call could be the first one that noticed the mar=
ks
> > attached to the inode are now watching children and is thus resposible =
for
> > setting children dentry flags even if 'set' was false. So I think it ca=
n do
> > only harm...
>
> You're right. It's wrong.
>
> >
> > And for similar reasons I believe fsnotify_recalc_mask() call in
> > fanotify_remove_mark() needs to be updated to
> > fsnotify_recalc_mask_and_update_children() as well. Standalone
> > fsnotify_recalc_mask() is simply never safe unless it is followed by th=
e
> > update children later - perhaps make it __must_check?
>
> Yeh... neither dnotify_flush() nor dnotify_handle_event() check return
> value now. I'll need to look into that.
>

Here is a candidate for v6

No more races.
Set a conn flag under lock for need_update
First thread to see the flag clears it under lock
and then updates children without lock.

Neil,

I removed your propagation of return value from
dnotify_recalc_inode_mask() because now the cost of checking
the flag is low enough to check it unconditionally.
If this still bothers you much you can put it back.

This is of course only sanity tested - none of the races are
covered by our tests.

Thanks,
Amir.

--0000000000002bd0fa0660b8c756
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v6-0001-fsnotify-update-children-flags-only-when-parent-star.patch"
Content-Disposition: attachment; 
	filename="v6-0001-fsnotify-update-children-flags-only-when-parent-star.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mwp9hh1r0>
X-Attachment-Id: f_mwp9hh1r0

RnJvbSAzMGRmYjI2ODgwNjVlNDczM2U4MWNlZjM5ODg5NGUxMTlmM2NmN2EwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDE5IE5vdiAyMDI2IDEzOjU3OjAyICsxMTAwClN1YmplY3Q6IFtQQVRDSCB2Nl0g
ZnNub3RpZnk6IHVwZGF0ZSBjaGlsZHJlbiBmbGFncyBvbmx5IHdoZW4gcGFyZW50IHN0YXJ0cwog
d2F0Y2hpbmcgY2hpbGRyZW4KCldlIG9ubHkgbmVlZCB0byBzZXQgdGhlIFBBUkVOVF9XQVRDSEVE
IGZsYWcgb24gY2hpbGRyZW4gd2hlbiB0aGUgcGFyZW50Cmlub2RlIHN0YXJ0cyB3YXRjaGluZyBj
aGlsZHJlbi4gIFdoZW4gdGhlIHBhcmVudCBzdG9wcyB3YXRjaGluZywgZmFsc2UKcG9zaXRpdmUg
UEFSRU5UX1dBVENIRUQgZmxhZ3MgYXJlIGNsZWFyZWQgbGF6aWx5IGluIF9fZnNub3RpZnlfcGFy
ZW50KCkuCgpUaGUgcmVjYWxjIHRoYXQgb2JzZXJ2ZXMgdGhlIHBhcmVudCBzdGFydGluZyB0byB3
YXRjaCBjaGlsZHJlbiBpcyBub3QKbmVjZXNzYXJpbHkgdGhlIHJlY2FsYyBvZiB0aGUgbWFyayB0
aGF0IGFkZGVkIHRoZSB3YXRjaC4gIEl0IG1heSBiZSB0aGUKcmVjYWxjIG9mIGEgY29uY3VycmVu
dCByZW1vdmVyIGluIGFub3RoZXIgZ3JvdXAsIG9yIGEgcmVjYWxjIGluIGEgY29udGV4dAp0aGF0
IGNhbm5vdCB3YWxrIHRoZSBjaGlsZHJlbiwgc3VjaCBhcyBkbm90aWZ5IGV2ZW50IGhhbmRsaW5n
LgoKUmVjb3JkIHRoZSBuZWVkIHRvIHVwZGF0ZSBjaGlsZHJlbiBmbGFncyBpbiBhIGNvbm5lY3Rv
ciBmbGFnIHdoZW4gdGhlCnJlY2FsYyBvYnNlcnZlcyB0aGUgdHJhbnNpdGlvbiBhbmQgbGV0IGNh
bGxlcnMgdGhhdCBhcmUgYWxsb3dlZCB0byB3YWxrCnRoZSBjaGlsZHJlbiBjb25zdW1lIHRoZSBm
bGFnIHZpYSBmc25vdGlmeV9jb25uX3NldF9jaGlsZHJlbl9kZW50cnlfZmxhZ3MoKQphZnRlciBt
YXNrIHJlY2FsYy4gIFRoaXMgd2F5LCB0aGUgY2FsbGVyIHRoYXQgYWRkZWQgdGhlIHdhdGNoIGlz
Cmd1YXJhbnRlZWQgdG8gZWl0aGVyIHVwZGF0ZSB0aGUgY2hpbGRyZW4gZmxhZ3Mgb3IgZmluZCB0
aGF0IGFub3RoZXIKY2FsbGVyIGhhcyBhbHJlYWR5IGRvbmUgc28uCgpBbHNvIGF2b2lkIHRoZSB1
cGRhdGUgY2hpbGRyZW4gd2FsayB3aXRoIG1hcmsgc3BpbmxvY2sgaGVsZC4gIFRoaXMgd2FzCm9u
bHkgZG9uZSBieSBkbm90aWZ5IGFuZCBjYW4gYmUgZWFzaWx5IGF2b2lkZWQuCgpGaXhlczogMTcy
ZTQyMmZmZWEyMCAoImZzbm90aWZ5OiBjbGVhciBQQVJFTlRfV0FUQ0hFRCBmbGFncyBsYXppbHki
KQpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgotLS0K
IGZzL25vdGlmeS9kbm90aWZ5L2Rub3RpZnkuYyAgICAgICAgfCAgNiArKysKIGZzL25vdGlmeS9m
YW5vdGlmeS9mYW5vdGlmeV91c2VyLmMgfCAgNCArLQogZnMvbm90aWZ5L2lub3RpZnkvaW5vdGlm
eV91c2VyLmMgICB8ICAyICstCiBmcy9ub3RpZnkvbWFyay5jICAgICAgICAgICAgICAgICAgIHwg
ODYgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCiBpbmNsdWRlL2xpbnV4L2Zzbm90aWZ5
X2JhY2tlbmQuaCAgIHwgIDYgKysrCiA1IGZpbGVzIGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKyks
IDI3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL25vdGlmeS9kbm90aWZ5L2Rub3RpZnku
YyBiL2ZzL25vdGlmeS9kbm90aWZ5L2Rub3RpZnkuYwppbmRleCA5ZmI3M2JhZmQ0MWQyLi4wYWZk
MmIwMzkzMzMzIDEwMDY0NAotLS0gYS9mcy9ub3RpZnkvZG5vdGlmeS9kbm90aWZ5LmMKKysrIGIv
ZnMvbm90aWZ5L2Rub3RpZnkvZG5vdGlmeS5jCkBAIC0xODEsNiArMTgxLDExIEBAIHZvaWQgZG5v
dGlmeV9mbHVzaChzdHJ1Y3QgZmlsZSAqZmlscCwgZmxfb3duZXJfdCBpZCkKIAl9CiAKIAlzcGlu
X3VubG9jaygmZnNuX21hcmstPmxvY2spOworCS8qCisJICogV2Ugb25seSByZW1vdmUgbWFzayBi
aXRzIGhlcmUsIGJ1dCBvdXIgcmVjYWxjIG1heSBiZSB0aGUgZmlyc3QgdG8KKwkgKiBvYnNlcnZl
IGFub3RoZXIgZ3JvdXAgc3RhcnRpbmcgdG8gd2F0Y2ggY2hpbGRyZW4uCisJICovCisJZnNub3Rp
ZnlfY29ubl9zZXRfY2hpbGRyZW5fZGVudHJ5X2ZsYWdzKGZzbl9tYXJrLT5jb25uZWN0b3IpOwog
CiAJLyogbm90aGluZyBlbHNlIGNvdWxkIGhhdmUgZm91bmQgdXMgdGhhbmtzIHRvIHRoZSBkbm90
aWZ5X2dyb3VwcwogCSAgIG1hcmtfbXV0ZXggKi8KQEAgLTM4MCw2ICszODUsNyBAQCBpbnQgZmNu
dGxfZGlybm90aWZ5KGludCBmZCwgc3RydWN0IGZpbGUgKmZpbHAsIHVuc2lnbmVkIGludCBhcmcp
CiAJZG5vdGlmeV9yZWNhbGNfaW5vZGVfbWFzayhmc25fbWFyayk7CiBvdXQ6CiAJc3Bpbl91bmxv
Y2soJmZzbl9tYXJrLT5sb2NrKTsKKwlmc25vdGlmeV9jb25uX3NldF9jaGlsZHJlbl9kZW50cnlf
ZmxhZ3MoZnNuX21hcmstPmNvbm5lY3Rvcik7CiAKIAlpZiAoZGVzdHJveSkKIAkJZnNub3RpZnlf
ZGV0YWNoX21hcmsoZnNuX21hcmspOwpkaWZmIC0tZ2l0IGEvZnMvbm90aWZ5L2Zhbm90aWZ5L2Zh
bm90aWZ5X3VzZXIuYyBiL2ZzL25vdGlmeS9mYW5vdGlmeS9mYW5vdGlmeV91c2VyLmMKaW5kZXgg
NjNjOTc1OWZjM2IwNi4uYzA2NGIwMDcwYzUxOSAxMDA2NDQKLS0tIGEvZnMvbm90aWZ5L2Zhbm90
aWZ5L2Zhbm90aWZ5X3VzZXIuYworKysgYi9mcy9ub3RpZnkvZmFub3RpZnkvZmFub3RpZnlfdXNl
ci5jCkBAIC0xMjY0LDcgKzEyNjQsNyBAQCBzdGF0aWMgaW50IGZhbm90aWZ5X3JlbW92ZV9tYXJr
KHN0cnVjdCBmc25vdGlmeV9ncm91cCAqZ3JvdXAsCiAJcmVtb3ZlZCA9IGZhbm90aWZ5X21hcmtf
cmVtb3ZlX2Zyb21fbWFzayhmc25fbWFyaywgbWFzaywgZmxhZ3MsCiAJCQkJCQkgdW1hc2ssICZk
ZXN0cm95X21hcmspOwogCWlmIChyZW1vdmVkICYgZnNub3RpZnlfY29ubl9tYXNrKGZzbl9tYXJr
LT5jb25uZWN0b3IpKQotCQlmc25vdGlmeV9yZWNhbGNfbWFzayhmc25fbWFyay0+Y29ubmVjdG9y
KTsKKwkJZnNub3RpZnlfcmVjYWxjX21hc2tfYW5kX3VwZGF0ZV9jaGlsZHJlbihmc25fbWFyay0+
Y29ubmVjdG9yKTsKIAlpZiAoZGVzdHJveV9tYXJrKQogCQlmc25vdGlmeV9kZXRhY2hfbWFyayhm
c25fbWFyayk7CiAJZnNub3RpZnlfZ3JvdXBfdW5sb2NrKGdyb3VwKTsKQEAgLTE1MzgsNyArMTUz
OCw3IEBAIHN0YXRpYyBpbnQgZmFub3RpZnlfYWRkX21hcmsoc3RydWN0IGZzbm90aWZ5X2dyb3Vw
ICpncm91cCwKIAogCXJlY2FsYyA9IGZhbm90aWZ5X21hcmtfYWRkX3RvX21hc2soZnNuX21hcmss
IG1hc2ssIGZhbl9mbGFncyk7CiAJaWYgKHJlY2FsYykKLQkJZnNub3RpZnlfcmVjYWxjX21hc2so
ZnNuX21hcmstPmNvbm5lY3Rvcik7CisJCWZzbm90aWZ5X3JlY2FsY19tYXNrX2FuZF91cGRhdGVf
Y2hpbGRyZW4oZnNuX21hcmstPmNvbm5lY3Rvcik7CiAKIG91dDoKIAlmc25vdGlmeV9ncm91cF91
bmxvY2soZ3JvdXApOwpkaWZmIC0tZ2l0IGEvZnMvbm90aWZ5L2lub3RpZnkvaW5vdGlmeV91c2Vy
LmMgYi9mcy9ub3RpZnkvaW5vdGlmeS9pbm90aWZ5X3VzZXIuYwppbmRleCA1ZjE5YzI0ZWMxODdm
Li42MDE4YzJkNzE3YWMyIDEwMDY0NAotLS0gYS9mcy9ub3RpZnkvaW5vdGlmeS9pbm90aWZ5X3Vz
ZXIuYworKysgYi9mcy9ub3RpZnkvaW5vdGlmeS9pbm90aWZ5X3VzZXIuYwpAQCAtNTYyLDcgKzU2
Miw3IEBAIHN0YXRpYyBpbnQgaW5vdGlmeV91cGRhdGVfZXhpc3Rpbmdfd2F0Y2goc3RydWN0IGZz
bm90aWZ5X2dyb3VwICpncm91cCwKIAlmc25fbWFyay0+ZmxhZ3MgfD0gaW5vdGlmeV9hcmdfdG9f
ZmxhZ3MoYXJnKTsKIAlzcGluX3VubG9jaygmZnNuX21hcmstPmxvY2spOwogCi0JZnNub3RpZnlf
cmVjYWxjX21hc2soZnNuX21hcmstPmNvbm5lY3Rvcik7CisJZnNub3RpZnlfcmVjYWxjX21hc2tf
YW5kX3VwZGF0ZV9jaGlsZHJlbihmc25fbWFyay0+Y29ubmVjdG9yKTsKIAogCS8qIHJldHVybiB0
aGUgd2QgKi8KIAlyZXQgPSBpX21hcmstPndkOwpkaWZmIC0tZ2l0IGEvZnMvbm90aWZ5L21hcmsu
YyBiL2ZzL25vdGlmeS9tYXJrLmMKaW5kZXggY2IwN2Y0MmQzNDIyMi4uMTY1OGZiZWY2MWRmYyAx
MDA2NDQKLS0tIGEvZnMvbm90aWZ5L21hcmsuYworKysgYi9mcy9ub3RpZnkvbWFyay5jCkBAIC0y
MzgsMjEgKzIzOCwzNyBAQCBzdGF0aWMgc3RydWN0IGlub2RlICpmc25vdGlmeV91cGRhdGVfaXJl
ZihzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25uZWN0b3IgKmNvbm4sCiAJcmV0dXJuIGlub2RlOwog
fQogCitzdGF0aWMgYm9vbCBmc25vdGlmeV9jb25uX3dhdGNoZXNfY2hpbGRyZW4oCisJCQkJCXN0
cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3RvciAqY29ubikKK3sKKwlpZiAoY29ubi0+dHlwZSAh
PSBGU05PVElGWV9PQkpfVFlQRV9JTk9ERSkKKwkJcmV0dXJuIGZhbHNlOworCisJcmV0dXJuIGZz
bm90aWZ5X2lub2RlX3dhdGNoZXNfY2hpbGRyZW4oZnNub3RpZnlfY29ubl9pbm9kZShjb25uKSk7
Cit9CisKIC8qCiAgKiBDYWxjdWxhdGUgbWFzayBvZiBldmVudHMgZm9yIGEgbGlzdCBvZiBtYXJr
cy4KICAqCisgKiBJZiB0aGUgY29ubmVjdG9yIHN0YXJ0ZWQgd2F0Y2hpbmcgY2hpbGRyZW4sIGZs
YWcgaXQgc28gdGhhdCB0aGUgbmV4dCBjYWxsCisgKiB0byBmc25vdGlmeV9jb25uX3NldF9jaGls
ZHJlbl9kZW50cnlfZmxhZ3MoKSB1cGRhdGVzIHRoZSBjaGlsZHJlbiBkZW50cnkKKyAqIGZsYWdz
LiAgVGhlIGNhbGxlciB0aGF0IG9ic2VydmVzIHRoZSB0cmFuc2l0aW9uIG1heSBub3QgYmUgYWxs
b3dlZCB0byB3YWxrCisgKiB0aGUgY2hpbGRyZW4sIHNvIHRoZSB1cGRhdGUgbWF5IGJlIGRvbmUg
YnkgYW5vdGhlciBjYWxsZXIuCisgKgogICogUmV0dXJuIHRydWUgaWYgYW55IG9mIHRoZSBhdHRh
Y2hlZCBtYXJrcyB3YW50IHRvIGhvbGQgYW4gaW5vZGUgcmVmZXJlbmNlLgogICovCiBzdGF0aWMg
Ym9vbCBfX2Zzbm90aWZ5X3JlY2FsY19tYXNrKHN0cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3Rv
ciAqY29ubikKIHsKIAl1MzIgbmV3X21hc2sgPSAwOwogCWJvb2wgd2FudF9pcmVmID0gZmFsc2U7
CisJYm9vbCB3YXRjaGVkX2NoaWxkcmVuOwogCXN0cnVjdCBmc25vdGlmeV9tYXJrICptYXJrOwog
CiAJYXNzZXJ0X3NwaW5fbG9ja2VkKCZjb25uLT5sb2NrKTsKIAkvKiBXZSBjYW4gZ2V0IGRldGFj
aGVkIGNvbm5lY3RvciBoZXJlIHdoZW4gaW5vZGUgaXMgZ2V0dGluZyB1bmxpbmtlZC4gKi8KIAlp
ZiAoIWZzbm90aWZ5X3ZhbGlkX29ial90eXBlKGNvbm4tPnR5cGUpKQogCQlyZXR1cm4gTlVMTDsK
Kwl3YXRjaGVkX2NoaWxkcmVuID0gZnNub3RpZnlfY29ubl93YXRjaGVzX2NoaWxkcmVuKGNvbm4p
OwogCWhsaXN0X2Zvcl9lYWNoX2VudHJ5KG1hcmssICZjb25uLT5saXN0LCBvYmpfbGlzdCkgewog
CQlpZiAoIShtYXJrLT5mbGFncyAmIEZTTk9USUZZX01BUktfRkxBR19BVFRBQ0hFRCkpCiAJCQlj
b250aW51ZTsKQEAgLTI2Nyw2ICsyODMsMTMgQEAgc3RhdGljIGJvb2wgX19mc25vdGlmeV9yZWNh
bGNfbWFzayhzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25uZWN0b3IgKmNvbm4pCiAJICovCiAJV1JJ
VEVfT05DRSgqZnNub3RpZnlfY29ubl9tYXNrX3AoY29ubiksIG5ld19tYXNrKTsKIAorCWlmIChm
c25vdGlmeV9jb25uX3dhdGNoZXNfY2hpbGRyZW4oY29ubikgIT0gd2F0Y2hlZF9jaGlsZHJlbikg
eworCQlpZiAod2F0Y2hlZF9jaGlsZHJlbikKKwkJCWNvbm4tPmZsYWdzICY9IH5GU05PVElGWV9D
T05OX0ZMQUdfVVBEQVRFX0NISUxEUkVOOworCQllbHNlCisJCQljb25uLT5mbGFncyB8PSBGU05P
VElGWV9DT05OX0ZMQUdfVVBEQVRFX0NISUxEUkVOOworCX0KKwogCXJldHVybiB3YW50X2lyZWY7
CiB9CiAKQEAgLTI5OCwyMiArMzIxLDMwIEBAIHN0YXRpYyB2b2lkICpmc25vdGlmeV9yZWNhbGNf
bWFza19jbGVhcl9pcmVmKHN0cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3RvciAqY29uCiAJcmV0
dXJuIGZzbm90aWZ5X3VwZGF0ZV9pcmVmKGNvbm4sIHdhbnRfaXJlZik7CiB9CiAKLXN0YXRpYyBi
b29sIGZzbm90aWZ5X2Nvbm5fd2F0Y2hlc19jaGlsZHJlbigKKy8qCisgKiBVcGRhdGUgY2hpbGRy
ZW4gZGVudHJ5IFBBUkVOVF9XQVRDSEVEIGZsYWdzIGlmIHRoZSBjb25uZWN0b3Igc3RhcnRlZAor
ICogd2F0Y2hpbmcgY2hpbGRyZW4gc2luY2UgdGhlIGxhc3QgdXBkYXRlLiAgV2hlbiBwYXJlbnQg
c3RvcHMgd2F0Y2hpbmcsIHdlCisgKiBjbGVhciBmYWxzZSBwb3NpdGl2ZSBQQVJFTlRfV0FUQ0hF
RCBmbGFncyBsYXppbHkgaW4gX19mc25vdGlmeV9wYXJlbnQoKS4KKyAqCisgKiBUaGUgY2FsbGVy
IG11c3QgbWFrZSBzdXJlIGNvbm5lY3RvciBhbmQgY29ubmVjdG9yLT5vYmogY2Fubm90IGRpc2Fw
cGVhcgorICogdW5kZXIgdXMuICBUaGlzIGlzIGFjaGlldmVkIGJ5IGhvbGRpbmcgbWFyay0+Z3Jv
dXAtPm1hcmtfbXV0ZXggZm9yIGEKKyAqIG1hcmsgb24gdGhpcyBsaXN0LiAgbWFyay0+bG9jayBt
dXN0IG5vdCBiZSBoZWxkIGJ5IHRoZSBjYWxsZXIuCisgKi8KK3ZvaWQgZnNub3RpZnlfY29ubl9z
ZXRfY2hpbGRyZW5fZGVudHJ5X2ZsYWdzKAogCQkJCQlzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25u
ZWN0b3IgKmNvbm4pCiB7Ci0JaWYgKGNvbm4tPnR5cGUgIT0gRlNOT1RJRllfT0JKX1RZUEVfSU5P
REUpCi0JCXJldHVybiBmYWxzZTsKLQotCXJldHVybiBmc25vdGlmeV9pbm9kZV93YXRjaGVzX2No
aWxkcmVuKGZzbm90aWZ5X2Nvbm5faW5vZGUoY29ubikpOwotfQorCWJvb2wgdXBkYXRlX2NoaWxk
cmVuOwogCi1zdGF0aWMgdm9pZCBmc25vdGlmeV9jb25uX3NldF9jaGlsZHJlbl9kZW50cnlfZmxh
Z3MoCi0JCQkJCXN0cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3RvciAqY29ubikKLXsKLQlpZiAo
Y29ubi0+dHlwZSAhPSBGU05PVElGWV9PQkpfVFlQRV9JTk9ERSkKKwlpZiAoIWNvbm4gfHwgY29u
bi0+dHlwZSAhPSBGU05PVElGWV9PQkpfVFlQRV9JTk9ERSkKIAkJcmV0dXJuOwogCi0JZnNub3Rp
Znlfc2V0X2NoaWxkcmVuX2RlbnRyeV9mbGFncyhmc25vdGlmeV9jb25uX2lub2RlKGNvbm4pKTsK
KwlzcGluX2xvY2soJmNvbm4tPmxvY2spOworCXVwZGF0ZV9jaGlsZHJlbiA9IGNvbm4tPmZsYWdz
ICYgRlNOT1RJRllfQ09OTl9GTEFHX1VQREFURV9DSElMRFJFTjsKKwljb25uLT5mbGFncyAmPSB+
RlNOT1RJRllfQ09OTl9GTEFHX1VQREFURV9DSElMRFJFTjsKKwlzcGluX3VubG9jaygmY29ubi0+
bG9jayk7CisKKwlpZiAodXBkYXRlX2NoaWxkcmVuKQorCQlmc25vdGlmeV9zZXRfY2hpbGRyZW5f
ZGVudHJ5X2ZsYWdzKGZzbm90aWZ5X2Nvbm5faW5vZGUoY29ubikpOwogfQogCiAvKgpAQCAtMzIx
LDI2ICszNTIsMzMgQEAgc3RhdGljIHZvaWQgZnNub3RpZnlfY29ubl9zZXRfY2hpbGRyZW5fZGVu
dHJ5X2ZsYWdzKAogICogY29ubmVjdG9yIGFuZCBjb25uZWN0b3ItPm9iaiBjYW5ub3QgZGlzYXBw
ZWFyIHVuZGVyIHVzLiAgQ2FsbGVycyBhY2hpZXZlCiAgKiB0aGlzIGJ5IGhvbGRpbmcgYSBtYXJr
LT5sb2NrIG9yIG1hcmstPmdyb3VwLT5tYXJrX211dGV4IGZvciBhIG1hcmsgb24gdGhpcwogICog
bGlzdC4KKyAqCisgKiBDYWxsZXJzIHRoYXQgbWF5IHNsZWVwIHNob3VsZCB1c2UgZnNub3RpZnlf
cmVjYWxjX21hc2tfYW5kX3VwZGF0ZV9jaGlsZHJlbigpCisgKiBvciBjYWxsIGZzbm90aWZ5X2Nv
bm5fc2V0X2NoaWxkcmVuX2RlbnRyeV9mbGFncygpIGFmdGVyIGRyb3BwaW5nIG1hcmstPmxvY2su
CiAgKi8KIHZvaWQgZnNub3RpZnlfcmVjYWxjX21hc2soc3RydWN0IGZzbm90aWZ5X21hcmtfY29u
bmVjdG9yICpjb25uKQogewotCWJvb2wgdXBkYXRlX2NoaWxkcmVuOwotCiAJaWYgKCFjb25uKQog
CQlyZXR1cm47CiAKIAlzcGluX2xvY2soJmNvbm4tPmxvY2spOwotCXVwZGF0ZV9jaGlsZHJlbiA9
ICFmc25vdGlmeV9jb25uX3dhdGNoZXNfY2hpbGRyZW4oY29ubik7CiAJZnNub3RpZnlfcmVjYWxj
X21hc2tfc2V0X2lyZWYoY29ubik7Ci0JdXBkYXRlX2NoaWxkcmVuICY9IGZzbm90aWZ5X2Nvbm5f
d2F0Y2hlc19jaGlsZHJlbihjb25uKTsKIAlzcGluX3VubG9jaygmY29ubi0+bG9jayk7Ci0JLyoK
LQkgKiBTZXQgY2hpbGRyZW4ncyBQQVJFTlRfV0FUQ0hFRCBmbGFncyBvbmx5IGlmIHBhcmVudCBz
dGFydGVkIHdhdGNoaW5nLgotCSAqIFdoZW4gcGFyZW50IHN0b3BzIHdhdGNoaW5nLCB3ZSBjbGVh
ciBmYWxzZSBwb3NpdGl2ZSBQQVJFTlRfV0FUQ0hFRAotCSAqIGZsYWdzIGxhemlseSBpbiBfX2Zz
bm90aWZ5X3BhcmVudCgpLgotCSAqLwotCWlmICh1cGRhdGVfY2hpbGRyZW4pCi0JCWZzbm90aWZ5
X2Nvbm5fc2V0X2NoaWxkcmVuX2RlbnRyeV9mbGFncyhjb25uKTsKK30KKworLyoKKyAqIFJlY2Fs
Y3VsYXRlIG1hc2sgYW5kIHVwZGF0ZSBjaGlsZHJlbiBkZW50cnkgUEFSRU5UX1dBVENIRUQgZmxh
Z3MgaWYgdGhlCisgKiBjb25uZWN0b3Igc3RhcnRlZCB3YXRjaGluZyBjaGlsZHJlbi4KKyAqCisg
KiBUaGUgY2FsbGVyIG11c3QgbWFrZSBzdXJlIGNvbm5lY3RvciBhbmQgY29ubmVjdG9yLT5vYmog
Y2Fubm90IGRpc2FwcGVhcgorICogdW5kZXIgdXMuICBUaGlzIGlzIGFjaGlldmVkIGJ5IGhvbGRp
bmcgbWFyay0+Z3JvdXAtPm1hcmtfbXV0ZXggZm9yIGEKKyAqIG1hcmsgb24gdGhpcyBsaXN0LiAg
bWFyay0+bG9jayBtdXN0IG5vdCBiZSBoZWxkIGJ5IHRoZSBjYWxsZXIuCisgKi8KK3ZvaWQgZnNu
b3RpZnlfcmVjYWxjX21hc2tfYW5kX3VwZGF0ZV9jaGlsZHJlbigKKwkJCQkJc3RydWN0IGZzbm90
aWZ5X21hcmtfY29ubmVjdG9yICpjb25uKQoreworCWZzbm90aWZ5X3JlY2FsY19tYXNrKGNvbm4p
OworCWZzbm90aWZ5X2Nvbm5fc2V0X2NoaWxkcmVuX2RlbnRyeV9mbGFncyhjb25uKTsKIH0KIAog
LyoqCkBAIC0zNjgsNyArNDA2LDcgQEAgdm9pZCBmc25vdGlmeV9tb2RpZnlfbWFya19tYXNrKHN0
cnVjdCBmc25vdGlmeV9tYXJrICptYXJrLCB1MzIgc2V0LCB1MzIgY2xlYXIpCiAJc3Bpbl91bmxv
Y2soJm1hcmstPmxvY2spOwogCiAJaWYgKHJlY2FsYykKLQkJZnNub3RpZnlfcmVjYWxjX21hc2so
bWFyay0+Y29ubmVjdG9yKTsKKwkJZnNub3RpZnlfcmVjYWxjX21hc2tfYW5kX3VwZGF0ZV9jaGls
ZHJlbihtYXJrLT5jb25uZWN0b3IpOwogfQogRVhQT1JUX1NZTUJPTF9HUEwoZnNub3RpZnlfbW9k
aWZ5X21hcmtfbWFzayk7CiAKQEAgLTEwMDcsNyArMTA0NSw3IEBAIGludCBmc25vdGlmeV9hZGRf
bWFya19sb2NrZWQoc3RydWN0IGZzbm90aWZ5X21hcmsgKm1hcmssCiAJaWYgKHJldCkKIAkJZ290
byBlcnI7CiAKLQlmc25vdGlmeV9yZWNhbGNfbWFzayhtYXJrLT5jb25uZWN0b3IpOworCWZzbm90
aWZ5X3JlY2FsY19tYXNrX2FuZF91cGRhdGVfY2hpbGRyZW4obWFyay0+Y29ubmVjdG9yKTsKIAog
CXJldHVybiByZXQ7CiBlcnI6CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5X2Jh
Y2tlbmQuaCBiL2luY2x1ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oCmluZGV4IGZhZjIxNTY0
MzgwZDkuLjA1MmQ4Njc0YWQ4OTYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZnNub3RpZnlf
YmFja2VuZC5oCisrKyBiL2luY2x1ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oCkBAIC01Njcs
NiArNTY3LDcgQEAgc3RydWN0IGZzbm90aWZ5X21hcmtfY29ubmVjdG9yIHsKICNkZWZpbmUgRlNO
T1RJRllfQ09OTl9GTEFHX0lTX1dBVENIRUQJMHgwMQogI2RlZmluZSBGU05PVElGWV9DT05OX0ZM
QUdfSEFTX0lSRUYJMHgwMgogI2RlZmluZSBGU05PVElGWV9DT05OX0ZMQUdfREVTVFJPWUlORwkw
eDA0CisjZGVmaW5lIEZTTk9USUZZX0NPTk5fRkxBR19VUERBVEVfQ0hJTERSRU4JMHgwOAogCXVu
c2lnbmVkIHNob3J0IGZsYWdzOwkvKiBmbGFncyBbbG9ja10gKi8KIAl1bmlvbiB7CiAJCS8qIE9i
amVjdCBwb2ludGVyIFtsb2NrXSAqLwpAQCAtODg4LDYgKzg4OSwxMSBAQCBzdGF0aWMgaW5saW5l
IF9fdTMyIGZzbm90aWZ5X2NhbGNfbWFzayhzdHJ1Y3QgZnNub3RpZnlfbWFyayAqbWFyaykKIGV4
dGVybiBfX3UzMiBmc25vdGlmeV9jb25uX21hc2soc3RydWN0IGZzbm90aWZ5X21hcmtfY29ubmVj
dG9yICpjb25uKTsKIC8qIENhbGN1bGF0ZSBtYXNrIG9mIGV2ZW50cyBmb3IgYSBsaXN0IG9mIG1h
cmtzICovCiBleHRlcm4gdm9pZCBmc25vdGlmeV9yZWNhbGNfbWFzayhzdHJ1Y3QgZnNub3RpZnlf
bWFya19jb25uZWN0b3IgKmNvbm4pOworLyogUmVjYWxjdWxhdGUgbWFzayBhbmQgdXBkYXRlIGNo
aWxkcmVuIGRlbnRyeSBmbGFncyBpZiBuZWVkZWQgKi8KK2V4dGVybiB2b2lkIGZzbm90aWZ5X3Jl
Y2FsY19tYXNrX2FuZF91cGRhdGVfY2hpbGRyZW4oCisJCQkJCXN0cnVjdCBmc25vdGlmeV9tYXJr
X2Nvbm5lY3RvciAqY29ubik7CitleHRlcm4gdm9pZCBmc25vdGlmeV9jb25uX3NldF9jaGlsZHJl
bl9kZW50cnlfZmxhZ3MoCisJCQkJCXN0cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3RvciAqY29u
bik7CiBleHRlcm4gdm9pZCBmc25vdGlmeV9pbml0X21hcmsoc3RydWN0IGZzbm90aWZ5X21hcmsg
Km1hcmssCiAJCQkgICAgICAgc3RydWN0IGZzbm90aWZ5X2dyb3VwICpncm91cCk7CiAvKiBGaW5k
IG1hcmsgYmVsb25naW5nIHRvIGdpdmVuIGdyb3VwIGluIHRoZSBsaXN0IG9mIG1hcmtzICovCi0t
IAoyLjU2LjEKCg==
--0000000000002bd0fa0660b8c756--
