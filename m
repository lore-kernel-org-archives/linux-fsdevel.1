Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793400247;
	b=n3jZ4VaMTfZH3DMpy7krJEgKCpdTH4lJ1FEJWPOQB2VZ6cNqfPY4Q3AeImseRp3SWE1V
	 aWYrxi1Yi/biAE+fjbZ5UNFHTAJ2CMBu/+n5ISvozB5TyvmDUg9Pf6vpI835kfzmvtRx3
	 mbbBlLXoLzCItgXw0ZN1AIAQawbGT//gdd8WK6i9EygGBOHBboWs4SNAMguFB2HhulS0U
	 PzHwe31MH5wIPfiwtCKUfPC2Ws8hYcGXnY7iC2kv0/8E2T3pBnVCPvpFkLa/FqGID28Ht
	 C9KFzvtUeqPZYyxFj0fJ4PZqY7a4ddys0j7r79Q8Q2ClNpCd5Adw0k8wBBoAdKORMZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+vnvo88Pr3dQY7eSVbimo7vIzM+xuPPq1OrMINl+rL8=;
	b=ynyNuqTG0FaR3cRKeOi8lahzL8iJ8jYTw7Cn5ERgm0iLFO+1Vh+Yw2BsL0LgYFaY5EJx
	 wQqUiUKwKOs2wgE127ZHim8iB7Casa6AwrVqV/7MNzvdX1WZNLwg3f78YHX3Sm+zi20fH
	 CnQP+fJPlUCbyFJqKtDKcUDEWG0BsHeJTepRakBTwWiPAskjUWoYbDlkD9vBExf4Imu/q
	 Ry6WfEEbSmyj6LOgH2J5nMPCw6PrCpVWpQ4GGivmNhYl+mwsxvzF/moRsw9DgESY+WLqQ
	 F127p2JESanZuzgY0EIvnxsgRmDdSrMXt+GmSHFDdyRUx9pCYfbF4jRKhoqYsDt4IYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DaiZLmwQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53736606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 22:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53736606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DaiZLmwQ
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ac97e45a79so11225451fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 15:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793400245; cv=none;
        d=google.com; s=arc-20260327;
        b=GzcmIEdZdVsBtJ1ngqUTnNHnLSmhjZB/Pp/NZBorEA8MxOpAv1WJX0KwNpdLD9l9yi
         /uAGRY5BS1j46a3DDxVMHMmVuQFd1iddkqwSsX/Jebmbf0m625SYh3bBywmevoqja0W/
         ncqa346iSwz+fuhzGHWL719bsHz/IG+FSTGDYMen6aWHshPkIJdzwT/oF+Z5aR2QbUGK
         Z7wj5U4eXXd87WEOqpfi+g7adHL8j+4kMUn/cogdCWZGlgecLe8VotAHeNHMqAPEQZ51
         ZcRZZ4UUCk0OvoKJgThPxNkGoo+hvTT4hy/cOnn4Mi1Oy8i6iZHbxLYRvfyBEjswpVCL
         EXRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+vnvo88Pr3dQY7eSVbimo7vIzM+xuPPq1OrMINl+rL8=;
        fh=nlyxQHXvIcfl94Y+p1WLvBYFypQ6fLkgEUtTLSDL8YU=;
        b=o8V4R6nQjQoJ6swnPQaeOBC9zPDB7gn6/S5srcn7EhywG4rs0svWscAFZc5a7oeZRs
         usS1rPbqMDtOa49SLAbGAeKjo7SVqr33G3DUlkwwBafxqcHp48AbJ1zDbTKZads6HiVb
         u0rVXtijgnvKuHFM9rE4elCDSpl8KuDmAzMnfYP0oB1pf1Ttm+Mi0pv0uMHYTFOaXXWT
         nK9mG2/cSrdobuTYTpJFCLaoTlzO3cvggs9Y5Gm/TAY+XG6g663m3gvsxeWNO7ze6L+x
         cfK1eEbpf9Y3xgepAp3VaYdqY4tIfO3igYzTK05SyNXWdYCKDtOkIB8COD2INndn91PL
         FPcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793400245; x=1794005045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+vnvo88Pr3dQY7eSVbimo7vIzM+xuPPq1OrMINl+rL8=;
        b=DaiZLmwQeVKbbcdVOyDCZyZxvLmchXpkwa6kU1MTGUpPaTuPAdDfGq0V4QSy0+e7bX
         b0djsAS8FyOOR3W52Qg6YzAzerrLCBVpq7nY+MxSj0j5lIi2ungzeDifs29L4IGMfolk
         vUkRosIQQ1t+JOdfgYq5iXS7fw9pjV7FBSmpiC1Zgex2wat6xMyz7LwVHydh7FZQ18Pk
         V5U1+RQU9/KzyxvYcSFLDB4cWd1lv+HjWcchRSFrFwNd+9add2cR5WSZFMgBjt05oqSY
         uuu1CuFi3rF5jSHSUWu5guBupRZ5HM+kS6UfQLzvmZ0E/CaNK/UbRTu0rtCd1L2LT4O6
         nvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793400245; x=1794005045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+vnvo88Pr3dQY7eSVbimo7vIzM+xuPPq1OrMINl+rL8=;
        b=nJc3BZoAl/ylAL12wYVzYhlTjyauynH9rR3hyIVPXXqFwUq2/RlxhYOAVSBQ1PK31+
         5woMUieOgOuvzulMoilLaCsHBYEwboJtYVCP7QINcbbumDhbaNIu9I6Q8o9rbz/jYDWr
         BKY37iwE8r34339oqK/qRTdc2+fVf7SMUTqM2YCy3tyH55K3xBGmqXOKAuI+NVaLMsVh
         pldrSW31DqaBkz95dpT1pdQ4p55rISM6t5fro5UoEhopBbby+yWH5GjJzc35WdKsU/Ui
         btsT4NSL07SIl1LAoYNzFH69in4aaUo7meSsMYNu8hrvedLQjVZf3zzxwHdmFRf0IDtI
         vANA==
X-Forwarded-Encrypted: i=1; AKwUvBy2iuYFAdzoSClSAR8C24nVO8paxA4iRAC//03IqRV5J7b6WzfcNCpvPv1qsDVBy5Eaqi9WGlxYdWIR15qW@vger.kernel.org
X-Gm-Message-State: AFq9FYKzc93ivsxdXh6EU5/xQhkdy579u5EAzvLBLyh34mOO1nrP/dbS
	Kb/8j5QbCm2HXuFAQl0LrjqBUpXQs/3KNhdlxak9XsHEpfOWUllaG0IeyKicPiObaVtKO+yN9lz
	oMtyy1cuL6ptxeI8zZesdQkStPe6IT3VG5JBBEZ3r
X-Gm-Gg: AYBFou3Li61SbhmE6MCWeXkSs2Kojz1kFQFJO0IWiGG/V5SCwqwySXPpI4naSkMNmlH
	d9fGCRQ3y76ZW/D87ppqxYSvV7DhGAxllUyixex9gnzFsIhSdC7W/301LNoqepSO/KKwnVfykPu
	qznyrz3KYmtjRa1Fnfr87ujv+Z3DVxD/j0jzGWQidgkCK8JTxcxQVNrDzSi/3EQ5hVxoEOpgRbi
	3Ij7Hp71LPAat/lspoPWpX1wGMQBN46mzmUwYAXNdWPE2IMMfK/NQodpGZxonECRu79RTkH3AL5
	yIPIUy/Z4X88dXr2XUt68g/IbyxuVVr2AnscsCtCWxa8CKMOVMyG4b+RnIYzo3rRyRJSMZ9fw/O
	3FHm0hUqo27E74nEmTVJUjvPntyqhGigemw==
X-Received: by 2002:a05:6512:a94:b0:5bf:b246:87a2 with SMTP id
 2adb3069b0e04-5bfd957b610mr1268679e87.10.1793400245078; Fri, 30 Oct 2026
 15:44:05 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026220546.3114241-1-skhawaja@google.com> <d4891333-43ea-4d74-9fb9-6ad8dac1a446@kernel.org>
 <20261030121113.GB3889730@ziepe.ca> <2c7aa5c1-3af3-4654-b244-1257d05c9d45@kernel.org>
 <auTR9SnDLsLVmnJ7@google.com>
In-Reply-To: <auTR9SnDLsLVmnJ7@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 30 Oct 2026 15:43:53 -0700
X-Gm-Features: AclHuK84pmgR6t7GwgKZ09yPCaz9JinHcZg2AVlK1zJKyqi05vBjmcmKbMe2QqI
Message-ID: <CALCETrV5eqg6d9=+BQhCpRwBNe3aCQiut8vxPBs8b7PToqjaHg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/memfd: add F_SEAL_PUNCH_HOLE
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Jeff Xu <jeffxu@google.com>, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:40=E2=80=AFAM Samiullah Khawaja <skhawaja@google=
.com> wrote:
>
> On Fri, Oct 30, 2026 at 03:39:40PM +0100, David Hildenbrand (Arm) wrote:
> >On 10/30/26 13:11, Jason Gunthorpe wrote:
> >> On Fri, Oct 30, 2026 at 11:20:30AM +0100, David Hildenbrand (Arm) wrot=
e:
> >>> On 10/26/26 23:05, Samiullah Khawaja wrote:
> >>>> This series introduces F_SEAL_PUNCH_HOLE, a new memfd seal that prev=
ents
> >>>> holes from being punched into a shmem or hugetlbfs memfd while leavi=
ng
> >>>> the file fully writable.
> >>>>
> >>>> Background
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> Drivers such as udmabuf and iommufd (via IOMMU_IOAS_MAP_FILE) use
> >>>> memfd_pin_folios() to pin the folios backing a memfd and hand them t=
o a
> >>>> device for DMA. Pinning keeps those folios allocated, but it does no=
t
> >>>> keep them in the file. If userspace later calls
> >>>> fallocate(FALLOC_FL_PUNCH_HOLE) or madvise(MADV_REMOVE) on the range=
,
> >>>> the folios are dropped from the page cache while the device continue=
s
> >>>> to use them. The pin holder is never notified, and from that point o=
n
> >>>> the device and the file silently diverge.
> >>>
> >>> We have the exact same situation when userspace maps anonymous folios=
 into vfio
> >>> and then desides to MADV_DONTNEED the pages. Or any other memory back=
end that is
> >>> used for such purposes.
> >>>
> >>> User space must not zap/punch things that might be pinned elsewhere.
> >>>
> >>> That's not specific to memfd, udmabuf, iommufd or anything else.
> >>>
> >>> I don't see a reason to make userspace (that should not shoot itself =
into the
> >>> foot) a kernel feature it must activate itself to not shoot itself in=
to the foot.
>
> Agreed, for normal use this is userspace's problem. The seal was meant
> for the kernel to cheaply verify at preserve time that nothing was
> punched.
>
> >>
> >> The issue is live update doesn't preserve those background punched
> >> folios and now we have created an UAF attack on the kernel across
> >> kexec if you don't do something about it.
> >>
> >> There was some notion here that with the right sealing flags we could
> >> tell if everything was 'live update compatible' and then know that
> >> these attacks are impossible.
> >Just remember that there was any hole punch and refuse to live update th=
is instance.
> >
> >We could likely implement "we saw hole punch on a pinned folio" as well,=
 but I
> >don't think that's required initially.
>
> If I understand correctly, you mean recording on the memfd that a hole
> punch happened, and refusing the live update if it did? That would work
> and is much cheaper than what we do today, where iommufd walks all the
> mapped pages at preserve time. For truncate, the existing F_SEAL_SHRINK
> is enough or I can record that also on the memfd. I will send patches
> for this.

This entire situation continues to give me the willies.  After much
prodding and contemplating (in my own brain), I got a friendly LLM to
report:

--- begin AI output ---

IOMMU_IOAS_MAP_FILE uses memfd_pin_folios(). Collapse [MADV_COLLAPSE
or khugepaged] checks the old folio=E2=80=99s reference count, so a pin
acquired before that check makes collapse fail.

  The problematic interleaving is:

  1. collapse_file() locks and unmaps the old folio, then passes its
reference-count check (mm/khugepaged.c:2446).
  2. memfd_pin_folios() (mm/gup.c:3483) obtains the old folio from the
file=E2=80=99s XArray and pins it, without taking the folio lock.
  3. Collapse copies the contents and replaces the old cache entries
with the new huge folio. It does not repeat the reference check or
freeze the old count.
  4. IOAS retains the old physical pages; accesses through the file
use the new folio.

--- end AI output ---

Is this correct?  I haven't personally verified it.  But this whole
pinning-folios-doesn't-keep-them-in-the-mapping situation seems
*extremely* fragile.

--Andy

>
> >
> >No need for more shaky seals.
> >
> >--
> >Cheers,
> >
> >David
>
> Thanks for the feedback,
> Sami
>


--=20
Andy Lutomirski
AMA Capital Management, LLC
