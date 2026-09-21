Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40274A4821
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000993; cv=pass; b=cgDgnExOzU9y3SrHLXV2bQLqO/UHkfSoD43BLQExKBCojWcOBdg2Dx/N1wsguXGA5CfTpStEBFZu4dCJ64uGZLEDs1/Z73VdWRh7FGt/GL4tuNf7m0c3F6AyNS11v2jrmh/T8Rr8JR3AsXK8UiP7qYf3h4UiQ2T1+RNBHf3jluM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000993; c=relaxed/simple;
	bh=nhZAhT6Xf3UYOMAXe+xBhzJdhzWUHNF7HVnNwVEr5t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foGZl7o76WcaDdY9CsmfKz19AQ6wlUIZkfmmxuDkuUYkm9Le1npj1GfwA1Oo80nPuRTMw0yAgrNMIKbVBgnLg6x/nJR/ic0HJvFgBza6TJspHJrrcmC8YRXs9EzYMLh2W46GhoXLrYe9U3PvklicKZex0F7B9F+TBIoHz/Vvx4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=hsmzMPaY; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="hsmzMPaY"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0c89e34so1899377a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 07:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790000989; cv=none;
        d=google.com; s=arc-20260327;
        b=SijwiD6kH08QuaIMqeJ9mXQJpH1+I6QIlArzO63sD4NvMD8n5sVQq6IOpGm1GEoKCq
         tsMY8RNBsIJ9La4i/6j3RMX2nPevSCQmptGZ0syKyj/AFtvWcdc5XGY6w24qIJHIMEoI
         1FNlk2/MEc9IGLf2PrtUGKnTp6fd+gwNmno0pvxwsOZA3RUQr5q6IOGKx1g/bbBWQOoP
         5eqqYRRKZnD+xtfrt67lVSXmAmV+siDjtkVLMUOcwrK+fDaEgeVPfsPu819lF8vyvQdr
         Tqg9ZHQsGeDwQbmaNeSSWCd928j8ycgbnLWJlFoc5+j5EnLXg/FNx2qfjbrbuVW+LNp+
         EEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8XN4vBfS9vmMaAbxJqiihHdmePkcL2PHUXmsVj1n1po=;
        fh=DDAL9BPILKj8KSc64AL7R15FiCsLpa+tir6GG7a/Sqc=;
        b=Y3hVLF8C3M2zW6RNqWfELqNknpnwPGzRaab6nuYdxKDzhmmaiQOVqx9COV1ZlmONfS
         ZhjKNK/4pJlmWpeSfXAEwPEKlVExpChjvNVDEoKE6+pk99h6XDHjxHq6cBhLnSmz3zUJ
         8WVkaxY+3Qm6wNTwNtRtkDqD6b4LFe5SiRyPYgHEsdVYbLa5Z5PSAchzUefrv1g15KsJ
         ZLkt+SwLDboiiVgLtUIpuBevAiA8XNQHwWXwryPn3Lz3NxLKNMxblq5hJ8yr+jPjQVG6
         S1/wBF+yHh5Ke+9cjEDFb3sQuprgP9yut4r7Urn3FqKj8XV4QmwjGjzDEbXr17nPcEZK
         zMKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790000989; x=1790605789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8XN4vBfS9vmMaAbxJqiihHdmePkcL2PHUXmsVj1n1po=;
        b=hsmzMPaYPCiCsYP8QpDExJC7q2kp8QGpZgUZ6xBxGY1JL6xgD1tHFjVrzmeD3tiBJ4
         MiGyz04jynYCjuvixEHlxYqgD7hIPlPepBeqc6KeCPOcWC9uJ5QtUbNqwrcdNOwJrlid
         7vx4TSLAprKoKOZs0izlZL1CwPHzRDfJ5IZxKAyWpq/GDulGhtwjNqaJOpXI2e6rQd/Z
         KguD+crOc0cTSnoFk7hvixw05qvXr8BJ+z8UBQ3W+9Y5SFehMBFD8sd7S8t1i1s/Onuy
         KX9uBcDFnCfQeLVa8xJ5Z/Xk3ap/9XbxZFg37TrjWyW2iQjPeTHPzUiaI1p93Vq81DBH
         G83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790000989; x=1790605789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8XN4vBfS9vmMaAbxJqiihHdmePkcL2PHUXmsVj1n1po=;
        b=CsSuRoF+Ybm0os2XJ+8bNicz1ivxX2qvH0B8lpAdD9lyZ1ZqlLtSPVx4DDM9XdWzIU
         aWmVvNKEK2gHKSyd4vFNZatqLVDiewPaC3Ux6YDHJTycXuI4dDqFP7p0pShHZ074nCO+
         vrrh8txLh0E6Th4UBmLEqaM4Yyyq0rh7HvNNPMVUh04GLQ2efdpVr+vWqmhfzLTfKBjK
         ifi1+KJKviAWHAjle8nvxeuoqyzxJS0Rzc6NOppMS/+vi5Hm5MHSFY1FAIcMhuRkPzKn
         fkLGD8Bx0iQMZCdz9wmXAtOppv8sVCoKFgu5hk9U8yOQyUmmira70sACtSdSjOKevUnu
         74bQ==
X-Forwarded-Encrypted: i=1; AKwUvBx96VutH+WRqZU+2RZz50SOr3CMz9UZyPV+7ELVoinAXXzmsoMYk9QjI5hK2cK8IE4MXCPX1OFWg8F+YO+K@vger.kernel.org
X-Gm-Message-State: AFuF++keYCIKwNqUKpqsGfKNRaMmmnHdfKEZwFAg2hZXHS+lvduZ524g
	IfstJ7UvTpeRX8lIZ+AnniCvHda5MYnm/usQKFscVKTs/qpWlrUHxllap4amlOWzeNm4aPrdP/t
	oBlwn08/YchuEh4+V+HVZgtLB/wgX75aI/hKuY47tAA==
X-Gm-Gg: AYBFou0mwkTvLhcDTQ6MuZKbU4bw8PrzIAKLnI99yeLmILLFpdX1xr5eHFrcIK8QrjW
	hqfsWy3U6VtHJLLlnvzHQFEKIESXxqDElleQUw9FevPH+5BxFTbwvlxINEWHawh1YC1O9pl0HtA
	ntFpGMYsh4wx5QvQ8xiL3LRYNPV/Awkcr56Tf+aO/LBLSR5SzLUl8A2cfl6csckBxNLgR/8vEBp
	5L/7MPkoBZUDSbOIJCcA85lqJt5JLNVI62YaQFUPUDITqEbGGRDOhBKFcPfHY/2jju4FKx7TfCc
	z5Yd0pq3nrrypEfshCeWIR9VOO8oqotnfPWociTVk2nInRa/qdJUouw3RathyASFDbVYoM5tqH3
	ek940xghkEg==
X-Received: by 2002:a05:6830:67e4:b0:805:2f63:2fa0 with SMTP id
 46e09a7af769-80de0d5681emr10524460a34.8.1790000989605; Mon, 21 Sep 2026
 07:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918130853.216497-1-bruno.produit@trailofbits.com> <5da11ad3c9c7954ad52b04880b61d9cdcdd0211a.camel@dubeyko.com>
In-Reply-To: <5da11ad3c9c7954ad52b04880b61d9cdcdd0211a.camel@dubeyko.com>
From: Bruno Produit <bruno.produit@trailofbits.com>
Date: Mon, 21 Sep 2026 16:29:38 +0200
X-Gm-Features: AcwNN1WfPjTcVdluttCCfBvVkT5EnAROfq9c-2jOiHvrDxLSOVhYuPDvQIkk-hM
Message-ID: <CAN3w+PMEuRuYVsR9P+Hf9aCd-dJih24OVkd2j5xuAgODJ2f7LA@mail.gmail.com>
Subject: Re: [PATCH] hfs/hfsplus: serialize B-tree close against folio release
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Dominik Czarnota <dominik.czarnota@trailofbits.com>, 
	syzbot+d729df28d933979e017a@syzkaller.appspotmail.com, 
	syzbot+2eac7d175baf21e6a5d5@syzkaller.appspotmail.com, 
	syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com, 
	syzbot+adeb387cede15eb11607@syzkaller.appspotmail.com, 
	syzbot+ae7f2423f3648100506d@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 9:57=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> On Fri, 2026-09-18 at 15:08 +0200, Bruno Produit wrote:
> > From: Kyle Zeng <kylebot@openai.com>
> >
> > From: Kyle Zeng <kylebot@openai.com>
>
> Why do we have the same email two times here? :)
>

Sorry for the mix-up, I was unsure about git send-email.

> >
> > B-tree nodes with a zero reference count remain in the node hash
> > until
> > folio reclaim or tree teardown frees them.  The folio release
> > callbacks
> > remove nodes while holding hash_lock, but hfs_btree_close() walks and
> > frees the same hash without that lock.  Reclaim can therefore unhash
> > and
> > free a node after close has loaded its pointer, causing a use-after-
> > free
> > or double-free.
> >
> > Detach each node with hfs_bnode_unhash() while holding hash_lock
> > before
> > inspecting and freeing it.  Drop the lock before hfs_bnode_free() so
> > a
> > large tree is not freed while holding a spinlock.  Apply the same fix
> > to
> > the matching HFS+ implementation.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> I think we need to have Cc: stable@vger.kernel.org here too.
>

Added to CC

> > Reported-by: syzbot+d729df28d933979e017a@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dd729df28d933979e017a
> > Reported-by: syzbot+2eac7d175baf21e6a5d5@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D2eac7d175baf21e6a5d5
> > Reported-by: syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D7155b2fe09e033c91381
> > Reported-by: syzbot+adeb387cede15eb11607@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dadeb387cede15eb11607
> > Reported-by: syzbot+ae7f2423f3648100506d@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dae7f2423f3648100506d
>
> Does this fix really eliminates these reported issues? Have you tested
> all of these cases? It will be great to have this clarification in the
> commit message.
>

These crashes do not have test cases to reproduce as far as i
understand (nothing in the repro columns). They do all seem to be the
same UAF in the {hfs,hfsplus}_btree_close() (or
{hfs,hfsplus}_bnode_unhash()) and follow the same pattern, which is
why I included them. Let me know if I should remove this :)

> > Assisted-by: Codex:gpt-5.6-sol
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
> > ---
> >  fs/hfs/btree.c     | 11 ++++++++---
> >  fs/hfsplus/btree.c | 11 ++++++++---
> >  2 files changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> > index 41b4e8fc9..d85a1df9f 100644
> > --- a/fs/hfs/btree.c
> > +++ b/fs/hfs/btree.c
> > @@ -310,14 +310,19 @@ void hfs_btree_close(struct hfs_btree *tree)
> >               return;
> >
> >       for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> > -             while ((node =3D tree->node_hash[i])) {
> > -                     tree->node_hash[i] =3D node->next_hash;
> > +             for (;;) {
>
> I really dislike this infinite loop pattern. Could we have a loop is
> limited by some value?
>

I'll send a new patch removing this pattern and keeping the while loop.


> > +                     spin_lock(&tree->hash_lock);
> > +                     node =3D tree->node_hash[i];
> > +                     if (node)
> > +                             hfs_bnode_unhash(node);
> > +                     spin_unlock(&tree->hash_lock);
> > +                     if (!node)
> > +                             break;
> >                       if (atomic_read(&node->refcnt))
> >                               pr_err("node %d:%d still has %d
> > user(s)!\n",
> >                                      node->tree->cnid, node->this,
> >                                      atomic_read(&node->refcnt));
> >                       hfs_bnode_free(node);
> > -                     tree->node_hash_cnt--;
> >               }
> >       }
> >       iput(tree->inode);
> > diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> > index 2ea8cd565..a90c9f416 100644
> > --- a/fs/hfsplus/btree.c
> > +++ b/fs/hfsplus/btree.c
> > @@ -417,15 +417,20 @@ void hfs_btree_close(struct hfs_btree *tree)
> >               return;
> >
> >       for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> > -             while ((node =3D tree->node_hash[i])) {
> > -                     tree->node_hash[i] =3D node->next_hash;
> > +             for (;;) {
>
> Ditto.
>
> Thanks,
> Slava.
>
> > +                     spin_lock(&tree->hash_lock);
> > +                     node =3D tree->node_hash[i];
> > +                     if (node)
> > +                             hfs_bnode_unhash(node);
> > +                     spin_unlock(&tree->hash_lock);
> > +                     if (!node)
> > +                             break;
> >                       if (atomic_read(&node->refcnt))
> >                               pr_crit("node %d:%d "
> >                                               "still has %d
> > user(s)!\n",
> >                                       node->tree->cnid, node-
> > >this,
> >                                       atomic_read(&node->refcnt));
> >                       hfs_bnode_free(node);
> > -                     tree->node_hash_cnt--;
> >               }
> >       }
> >       iput(tree->inode);
>
