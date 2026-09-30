Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588604FECEE
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782172; cv=pass; b=EkpRpL4HpQY9JGx/+qeUhP+7LNV7BEYdE6LbASdrUYLAiGysMr3PQqYmSvQQ6K1/HvqogbdKD+KWmmuag7n51ZTUoeMWeADqAI9p8cMoFUwnJ9yUQ23oDkpWNm3re5B2yfjJs3XkutIQXi0N1dk+2GHXd+8UPVFgl6aTmOa3vkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782172; c=relaxed/simple;
	bh=MnJSCqgC82FmNpPlZz41kAzNK3OQ2EjaqHBY9KctmXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVDG2HacKQjQJQbh56klbJkAGIazix8iopVxIhF0ZDMaYGIzTJogkg6hEcytvleTluep1vzsd8cimzq/gnDb2tlap0/h7HeNUN7D1qikJgkEKOMXFChvUiVJMUhtEqRGTA6P5AxBWqhp4dGVLLzHGb4PuGIh+E60t60Y6dL5MQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3wLSFXI; arc=pass smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3wLSFXI"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-9178b9ca7e8so15724566d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 08:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790782162; cv=none;
        d=google.com; s=arc-20260327;
        b=IWyn963N9ufUFi7HCVbe7v6g8WiJtLne0Tfe0/EwjcosULrXWqAeDEKzmcLasWgVix
         EZKoPDF6Znoyb8m+OJGrY0WXFdRpWk+jJdpdWsESPl6ERqy+Mp7N9BGLRqkdc/QlNI+S
         pRlrPCL5Ty9tWcUmnW0irCiUvwE86np1aNL2+3s7Tpj4ivMzrzrDVhZJoB1mF/eC7c8F
         pggbJj7zNgWVvul93VOFC7v335GePxR9dsFhRnW7Bm2fs8zfYsdJR3s29QIOnprNOYmC
         arILz28kw/AxUvt2epxH0r7dtRUc1ixZGBUbzwSga0Qa4UD7uI7btRgpqIKmPL9O9VYn
         4XxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+s4UUy/dbmXVrn6D88sSbqjQQFVAT3AI4v3oDb3NPoo=;
        fh=Nis9G0RDlbmiGri1Hituv405NRImRitc0xGivMilTg4=;
        b=pN3Y5rBMUvPfNG2wumvWy2Q8duEp5DzkswXHBEuuMz+GVWbIgd60VX7ppuPTBO9y51
         KFKKzVhHokWhpfuidNEtO3vTBUbwrFY5LlflzLRj23vA5MMEwQ7SnpLaMzwVrCRfCJyY
         J+BzfTZgLPO6toF/rOHFmUoUG34PImA+idPznoc0kYM6RC9NmFQSbLx5nw7ctOB8k9R8
         rALmv3wZMZGCCdYKOpBvCo1p9k9g66GX01p20HhxmahyYPhOWSvQ4juNuWLmTbnfWhHs
         zPc5qAyDjel9JYqyxz8mr4mgiZjJsw6+zAjEGcfW74DPiNFMerbfamjL/yohW0UZXOmw
         KncQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790782162; x=1791386962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+s4UUy/dbmXVrn6D88sSbqjQQFVAT3AI4v3oDb3NPoo=;
        b=o3wLSFXIlgwbaJ0H4I825Tw8OmfyIORWgHDiUAugiOA8bst3/RwalfE1KcIPfp5Dnw
         xWqGj8yVoS6k+9PChUxZcXgmQygxdBupNR/XDSRnJrkluXYtDIiq/a86zAvGAn4d5KM6
         bWkDSArVQqD6Ap02Es5sLNPM3YCd7BoEuo3qiXJLeCp4yfhae1fYNl6exZ8jNxwcOBGb
         VzHwRPjeDbxUafFX4QOS7ngH9mbOeHQbRzTAmD2jqP/O87LP1aGPN6CkZ1PjFSU5YsD3
         bb227VUx14LYA0flEJI9yhiFOsjwxMz+sDsMx2/iGhaIeZG4D3KNoobIAFeNEPB3smTQ
         RFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790782162; x=1791386962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+s4UUy/dbmXVrn6D88sSbqjQQFVAT3AI4v3oDb3NPoo=;
        b=O8xmsoP4VY9drYboVWvaNMqv82LrSr7ylHeG+zL5FMSwooRh2tX/eGqG+RXQl8NBwi
         mFGgTFVtJwXCqHsaCzvq0CwWV0jKtdtbWf0SSIaPRW8D83FJzz7lnAxUcamYLh0lcIdD
         43DdVIwXwbJj/4FfxWUUAu9vNmNvFXJrKU5ZRIUI19Cd/QisWFs4IUGku7GKZHI7D3oU
         xBY5ICZGdKzoRlwaMZMy7qNmL4uJ9as7yKhUsn0f5O4xjCZYmz3VahfwBnV2FA+E5Fws
         avF40QDPLHkiuHjWHRC36qjfev1kDbh22OYJSU7NKqPgVh7jqjniMOjPrmzrmtXtHxLV
         G5Nw==
X-Forwarded-Encrypted: i=1; AKwUvByPEIRAPUuX8qYVau7LoQUChbSeWOZUobOaLlI7Ha14YZB0XjiUqh8R5/cYHTehI43KubTsu0dNjrGQ+SUs@vger.kernel.org
X-Gm-Message-State: AFuF++kUZYUUTLxAR+60uZvuS5lPNOMA5dCS0PhrsgGBJyHZMxRuRv1B
	zvoL27KcXO/xFkeIgBt+J8aE6iCatXfUL36EvPH+pibUbV8RLheqCqNcGeo21G8J1gJXU2dZZPD
	OcQrK9CmnBYbO52ouZhwMx+pbHjdgwYk=
X-Gm-Gg: AYBFou0xtSujYNW5hKFEk8oFLcnHglSB83DjSNxFzmOOTn9e+LhiB8cOZCImMTd3mSD
	ee2Anz/HNHC40fAwiN4lxXIYJWbEaJBJC/z7AFU1jUX8umW2ZlBphI1a6msOdx0d9XZ+A06Gv0g
	Iolxt6SWG5spYrvSlM0oWzRadK21no4GSGKAQzdx78ZdHOxTp0nu08FJFDMuRnGzBIbkNkfuFa5
	Cf4NfH3IE8d4+4j23qP2eWgldq7byiGcHFxJnnjBWGkkmOhBQYphveKrBmU7rfGrF8245da5D5l
	KcEg7GlHXaTiI9NMiOWtW1O5z1GlqoBCTVn0A8olPjgVXeaRT/Wt/RWDHZ3oqEGA9VDbsezqgb/
	N4SnnW5TNEVLnscM70Zn3vxVKcI5Xnf2kbYkb7rsG+cpkOmLE
X-Received: by 2002:a05:622a:1102:b0:530:f37b:cabc with SMTP id
 d75a77b69052e-5337485e6b1mr35467951cf.12.1790782161399; Wed, 30 Sep 2026
 08:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAE3jtcL_CZJdcattCwe0RraKnHcZO=UknxEUQVG858ouZCUQA@mail.gmail.com>
 <7ebe4591-2306-4b5c-b83e-6a2e34b52bd8@kernel.org> <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org> <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org> <art8EKRKMdwSDCkr@gremlin>
 <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
 <arz0auULA33fqoWu@gremlin> <arz8Plu6J4YOTi0a@gremlin> <CAAE3jtcanTUrV3xfofwrvYGCFe5o=Vn7gS66bDzuxzeGg6c5=Q@mail.gmail.com>
In-Reply-To: <CAAE3jtcanTUrV3xfofwrvYGCFe5o=Vn7gS66bDzuxzeGg6c5=Q@mail.gmail.com>
From: =?UTF-8?B?5aSp54u8?= <rockeet@gmail.com>
Date: Wed, 30 Sep 2026 23:29:09 +0800
X-Gm-Features: AclHuK83LCCP0gaa6JO7mCWIhwWocLHHA6V6Kq9BAXxYIFSYAN5NC5AE5EEmus8
Message-ID: <CAAE3jtdHi7aSsJ62TpEjkxvwA-3TBLvr5i1ohCNg2aupND+_XQ@mail.gmail.com>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file mappings
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David, Lorenzo,

The distinction behind this request is between surviving a process crash
and surviving a power failure. After a process crash, the kernel and page
cache remain alive. A shared file mapping therefore retains the writes
already made by the process, even if they have not been written to disk.

ToplingDB has file-mmap MemTables whose data structures survive a process
crash. Its crash-safe recovery reuses those MemTables instead of rebuilding
them by replaying the entire WAL. A published sequence number aligns the
MemTable's per-KV crash-safe boundary with the database's WriteBatch
atomicity, so recovery can reuse the published data and replay only the
remaining WAL tail.

These MemTables also support cheap, millisecond-level ConvertToSST
(wrap-up and sync, i.e. LSM flush). The file-mmap path renames the existing
file and appends metadata, preserving the data structure already built in
it. This avoids copying the contents into a separately constructed SST.
Moving construction into shmem would add a transfer to the regular file
that this path currently avoids.

Avoiding full WAL replay makes much larger MemTables practical. While a
large MemTable is being populated, random updates can repeatedly dirty
pages that background writeback has already written out. Those writes of
intermediate states consume disk bandwidth without being necessary for
process-crash recovery. Deferring them is a performance optimization;
correctness does not depend on the kernel honoring the hint.

This is a general problem, not something specific to ToplingDB. ToplingDB
explicitly distinguishes process crashes from power failures and has
invested heavily in optimizing recovery from process crashes. By contrast,
LMDB faces the same problem but does not explicitly distinguish process
crashes from power failures. If sync is skipped when using LMDB, the
remaining writeback problem is the same as in ToplingDB.

The global setting and kernel module described in my previous email let us
work around this locally. The remaining problem is making the optimization
available to users of a database library. We cannot reasonably require
every deployment to change a system-wide setting or install and maintain
an out-of-tree kernel module. The module gets us from no solution to a
local solution, but it does not provide a broadly deployable interface.

That is why I am asking for kernel support: a supported, best-effort hint
that applications can use directly, while leaving the kernel free to write
back when necessary. madvise is not the only option, deferring writeback
for the entire file would also be acceptable.
Per-file deferred writeback would require minimal kernel changes and pose
a very low risk, while offering enormous benefits.

Thanks,
Peng

=E5=A4=A9=E7=8B=BC <rockeet@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=B8=89 22:14=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi David, Lorenzo,
>
> We currently work around this issue by setting the global
> vm.dirty_expire_centisecs to 60000.
>
> We have also developed a kernel module as another option. It exposes an
> ioctl that takes a file descriptor. For an already-dirty inode, it update=
s
> dirtied_when to the current jiffies and moves the inode to the newest end
> of the writeback dirty list, postponing its selection by periodic
> writeback. It leaves the dirty state intact and does not remove an inode
> from an already-queued flush.
>
> To keep postponing periodic writeback, the application must call this
> ioctl continuously at intervals shorter than vm.dirty_expire_centisecs,
> expressed in centiseconds. Once the calls stop, the normal expiration
> interval applies from the last call.
>
> The key code, with checks and locking omitted, is:
>
>     inode->dirtied_when =3D jiffies;
>     if (!(inode->i_state & I_SYNC_QUEUED))
>         list_move(&inode->i_io_list, &wb->b_dirty);
>
> However, neither changing a global setting nor maintaining a separate
> kernel module is as elegant as having this supported directly in the
> kernel.
>
> Thanks,
> Peng
>
> Lorenzo Stoakes (ARM) <ljs@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=B8=89 20:11=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Sep 30, 2026 at 01:08:33PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > I'd say in general the shape of the solution would be something
> > > cgroups-ish, but since all of this is global stuff and the knobs are =
all
> > > global I think you need to think about your design a little more.
> >
> > (Sorry to be clear, this is - if we accepted that this was a kernel iss=
ue that
> > truly needed something like this - which I do not. The solution here is=
 to use
> > shared memory as per below.)
> >
> > > And in general we've seen a pattern of 'writes to MAP_SHARED, experie=
nces
> > > problems' before.
> > >
> > > And the solution is generally - use something like memfd, have a proc=
ess
> > > that does writebacks manually for you as you need.
> > >
> > > So I strongly suggest you do that! :)
> > >
> > > --
> > > Cheers, Lorenzo
> >
> > --
> > Cheers, Lorenzo
