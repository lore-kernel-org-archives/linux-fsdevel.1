Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7D48A8C8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634244; cv=pass; b=PySgkBog0sN2/YfYJ7s7UshlB/Ae3HfIVDTxIqLYYavtVZnt68O9bLW/1IhTM48+w0e4skRy2YFlNm5d22+Rcbgy8g8rbKQirdRu29Aj+A5YGWDMGgG0K0sVFiGOjskFx7nKCOysfYep0X49CMe/2tilm2iNzUTgJkUOa8oZL0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634244; c=relaxed/simple;
	bh=kBt/lsmHB1LyfCEjsXo+nfsL6J4j+X6MlkrToinPe6Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fD0qRIGMg6IYFBLvvKsMER42q0ddxKqD3L5S6ufbxN7+dDlS7f+IpLgex0HNkH4gjKPTJXTDZMO6xUNEpyDyw/cE7tHYlEGNGFeYuC2r7uRaQaU+WBD+PEdDik3N1rNYeEIDL2hYauNI53eJHldBanP+buxQa/VRACiKLRp1u3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qfpw7jsF; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfpw7jsF"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76ef1d0so4318181cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 01:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789634227; cv=none;
        d=google.com; s=arc-20260327;
        b=PwnY9syP/3koSvgyRfEiDmoRmhGLor3hm8m1QtW32hZLeLpaLr3hy9pvMYRXc4Q7Zm
         5E/RijStq48yFdEWB20b+wPAr+8RBAi3Ne0sanbsJ0vOQZSMTK6DuGVDsBbTYXiDwtQd
         S8Gkeyzcjb1HNdVBziTWmav4/k/I6Y4RawDsSZJ8Xll4xL/f4RquWXHYhhlqtTTaqdgc
         Q3LJhQ88X8/7K2bn68lZmNxAOGgcacIyxq+QrVtftMmuPKQ3iqJComXokdUYT+vHJVj7
         uCcHS6g5gOB/YcuyAUJP+r3Ec/9qb/e8H7xMeuB8UPiXMnztC6Keq2zMx6zt4ShynTgN
         sCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DSywNGd0PivnRhp7RJFiAn20BUh8Ya6uXvMwa7fJTPg=;
        fh=O/qXp8Errp16mWv9CRUt1DGHH8loxr0tRB92sibkZC8=;
        b=O2bJQhcPz3Kb4uZet0RyNzIDQ+NOaEipiwdARqaSPijJe7Vgof4Nb00Yjf2767hpDf
         ffy61p+OsyF24G68Rjr9tkc9l0PNkx8GjT/zm7anIe61J0xAjavKeon9NT92K88aK9kP
         3E6zbP1QDy3/CcdML9vfb81J6IhdlIuiDoHcla1BbIGaQOmNPAjJ75/KAqauojNReRDH
         dO3fWnNeONrPMWMMI364bK2+4MKzOTfxABe2UocfCEnVdmqdqeDekJuuda3TC2HLnlZ9
         2sycjYyuUrpIMXFytLODyK9Ye1pZWsUCMdc0nIsNYSoQkV7+N7WTesWyf4ft9tEU1f5c
         DVkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789634227; x=1790239027; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DSywNGd0PivnRhp7RJFiAn20BUh8Ya6uXvMwa7fJTPg=;
        b=qfpw7jsF4mZM5O3CATuIDFTphP8E6YTvS3NKBQqQfXLe9AZ0Z6rtJqg9SuyN8niYJ6
         iuzkBsyCKqxNQvfpyS5SMN1PexKTYSGwrSSKiwzneAMHpx8UCEoK0huCEgAu02EKay42
         IT0yi7ic6M3ALSHF9YJb8HW5UGjXJTFw8z8vZUA12O2P8LTqwOpVhsU2zjLDdjytE2j+
         PRF8rn/y0D9uQoEa3DDHHR1J/9AlyvZ6MouLW/M2JNzdMNFdRYPkj/lRomX2hSZ54yiY
         bvDKDSEC/7PBLpxdsN3e4f8vus19PDcewr72DjOesWbZ23TSNp+HYyCpLm0cNj0TqSI4
         d1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789634227; x=1790239027;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DSywNGd0PivnRhp7RJFiAn20BUh8Ya6uXvMwa7fJTPg=;
        b=xDqc/wzAecRFIjjviaqJabLflPcADcxbmQhd8qypNaUWk4lfc5iyJpXJ4gC2fMMTKP
         hwo333q654eeoqqbs3OIJZTQoSfiH60X1V2dmUjVEfjp61mA3FevKg6xuuWk1+L/ezHm
         FefHUYe5iS7u/ZRIwFUG1oeopoNL5ND8eujhblMlHd6vUB2HvUAuzm/oMS+46QV6iuVE
         l7H5EP6RgVd0ONLv9f+fiYNQ98UjFoXtFvHndZi4zXoNSxW07wBQfygy6k+7w9k4t1Nh
         fAa9MkHUzC7qcIRWcrsZTBiREzPnKyoHzCnVgarS+y3k67L17pDBtUyEUJGyqWHF8T6Z
         kcyg==
X-Forwarded-Encrypted: i=1; AKwUvBxsXUL6sJ2mB2ttNKlUlRRedZZqND/UKX4H2ku2dJZqVh3Z2c2yXw/l9y/30RgTQh/FXU9OUj2zSm971PBm@vger.kernel.org
X-Gm-Message-State: AFuF++kGS7ORseldUgoF1cyL2Oji6b+Es3cgkqHSoQBNEqTLJWoXaqdk
	5v8dLVm7f8/fmRCkt+M5iOX6013fsxq+64kybaQNGa8I0jxv3xFpA4KlTfcoa4Xau7jQ58y2K40
	odk1NSYjjLOh0D1eo0ozEvGHrvRQrGkoZqhYl
X-Gm-Gg: AYBFou0zIQskoD3MdXeJcspzwxTwWoxs5CpBv4BncPw31fuMsloH5s8HMS/cKl56e6g
	88TtLweV8MlEsIXXrb43Is0x87GsS7oFUcrNZL4X/SYnzv8np5QehXG3g/qUfACdp77W57r+TxI
	0yXRUR1oxt6oHiLoRbVDlgCxXUYRovTNZlmLidnOY2A1ceh+VXcQsf8Eb9f3llZ+uzkWQHkVZcj
	GryrdxRlaEtNwR+hEI1lp7gG2h7DYNBLB2m5EnbpKmr+L8dk9kXM5Ql4eas3zYv01apQhNBxRh0
	ke0BrZoIDpalJrebWq2FQzfYd30eXyEV28xBuJARA1QhmgnWpCU1Aszo
X-Received: by 2002:a05:622a:d2:b0:531:803:2a48 with SMTP id
 d75a77b69052e-5327eee89a2mr102193491cf.41.1789634226911; Thu, 17 Sep 2026
 01:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: dave mad maxXx <davemadmaxxx@gmail.com>
Date: Thu, 17 Sep 2026 05:37:32 -0300
X-Gm-Features: AcwNN1UOyjXjIRM2-nQ_fLD6Po8ADIjBSdT9MDKwMqIgRcWvhdx6Wr8GfSEi4Yo
Message-ID: <CADy8qZiJmfdwm11aV7z1mr+fjFJQ0kN8Wp6yBub0_0EP3uCssg@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in __hfsplus_brec_find
To: syzbot+f957cf00261d1c41fafd@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com, Viacheslav Dubeyko <slava@dubeyko.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000602a38065ba9b07e"

--000000000000602a38065ba9b07e
Content-Type: text/plain; charset="UTF-8"

Hi,

I am investigating the HFS+ crash reported by syzbot in
__hfsplus_brec_find() and would like to share the current results of a
function-by-function reconstruction of the failure path.

The public report shows the fault address:

fffffffffffffffb

On 64-bit Linux this value is consistent with the encoding of
ERR_PTR(-EIO). I am treating that correspondence as an important clue,
not as proof that -EIO originated at any particular call site.

STATIC AUDIT

The audit identified two concrete producer-to-consumer gaps in
fs/hfsplus/brec.c. In both cases, hfs_bnode_find() can supply a value
that is assigned to fd->bnode without an IS_ERR() check before
fd->bnode is subsequently consumed as a struct hfs_bnode pointer.

The first site is in hfs_brec_insert(), after a successful node split
and during the parent-node lookup. A second related site exists in
hfs_brec_update_parent().

hfs_bnode_find() has error-return paths using ERR_PTR(), including
-EIO. This makes error-pointer propagation through these unchecked
assignments a mechanism worth testing. However, the existence of these
paths alone does not establish that either site produced the error
pointer in the original syzbot execution.

RUNTIME REACHABILITY

I then tested the relevant control flow in an isolated QEMU HFS+ environment.

A clean HFS+ filesystem and a workload creating many long catalog
names naturally caused a Catalog B-tree node split and reached the
parent lookup in hfs_brec_insert(). No control-flow manipulation was
needed to reach that branch.

This established runtime reachability of the exact branch containing
the first unchecked hfs_bnode_find() assignment.

DIRECTED ERROR-POINTER EXPERIMENT

Only after the natural control flow reached that parent-lookup point,
I deliberately injected:

fd->bnode = ERR_PTR(-EIO)

The unprotected execution then faulted at:

fffffffffffffffb

This is the same numerical fault address shown in the public syzbot report.

I want to be explicit about the interpretation of this experiment: the
ERR_PTR(-EIO) value in this test was deliberately injected. Therefore
this is NOT a natural reproduction of the syzbot bug and does NOT
demonstrate that hfs_bnode_find() naturally returned -EIO in the
original report.

What the experiment demonstrates is narrower: if ERR_PTR(-EIO) reaches
fd->bnode at this reachable producer-to-consumer gap, the resulting
invalid pointer can produce the same fault-address value observed by
syzbot.

NAIVE CONTAINMENT AND CLEANUP BEHAVIOR

An initial diagnostic attempt added an IS_ERR() check after assigning
hfs_bnode_find() directly to fd->bnode and returned the corresponding
error.

That guard detected the injected -EIO, but the kernel subsequently
faulted again at fffffffffffffffb, this time through the cleanup path
ending in hfs_bnode_put().

The reason was that fd->bnode still retained ERR_PTR(-EIO). The caller
cleanup eventually executed hfs_find_exit(), which calls
hfs_bnode_put(fd->bnode) without treating ERR_PTR as a valid state.

This led to an additional source-level observation: fd->bnode appears
to have an effective cleanup contract of containing either a valid
hfs_bnode pointer or NULL, not an ERR_PTR value. Existing HFS+ code
also contains a safe pattern in which the hfs_bnode_find() result is
first held in a temporary pointer, checked with IS_ERR(), and only
then assigned to fd->bnode.

NEW_NODE OWNERSHIP

The split path also has a live new_node reference returned by
hfs_bnode_split(). Therefore simply returning on a failed parent
lookup would not be sufficient; the diagnostic error exit must also
account for that reference.

DIAGNOSTIC PATCH 40P

Based on those observations, I developed 40P as a diagnostic
containment patch. It modifies the two unchecked hfs_bnode_find()
sites identified in the audit.

At each site, the hfs_bnode_find() result is first stored in a
temporary pointer. If IS_ERR() is true, the patch:

1. obtains the error with PTR_ERR();
2. ensures fd->bnode is NULL rather than retaining the error pointer;
3. releases the live new_node reference with hfs_bnode_put(new_node);
4. returns the error;
5. assigns the temporary pointer to fd->bnode only after it has passed
the error check.

Under the same directed ERR_PTR(-EIO) condition, this diagnostic
version contained the tested error-pointer propagation without leaving
fd->bnode poisoned for the later cleanup path.

40P is a diagnostic patch only. It is not intended as an upstream fix.
Its purpose is to test and constrain the causal path while preserving
the local cleanup state observed in the source.

CURRENT EVIDENCE BOUNDARY

The evidence currently supports the following statements:

- The public syzbot report contains the fault address fffffffffffffffb.
- That value is consistent with ERR_PTR(-EIO).
- Two unchecked hfs_bnode_find() -> fd->bnode producer-to-consumer
gaps were identified in brec.c.
- hfs_bnode_find() can return error pointers, including -EIO on an error path.
- hfs_brec_insert() and the relevant post-split parent-lookup branch
are naturally runtime-reachable in the controlled HFS+ workload.
- A deliberately injected ERR_PTR(-EIO) at that reachable point
produces the same numerical fault-address value.
- A naive IS_ERR()+return is insufficient because fd->bnode can remain
poisoned and be consumed during cleanup.
- 40P contains that directed condition while maintaining fd->bnode as
NULL on the tested error exit and releasing new_node.

The evidence does NOT yet establish:

- that the original syzbot execution naturally obtained -EIO from
hfs_bnode_find() at this site;
- that either of these two unchecked assignments is the complete root
cause of the public crash;
- or where the first naturally occurring invalid/error state
originates in the syzbot execution.

NEXT DIAGNOSTIC QUESTION

I am continuing to move the observation point backward around the
Catalog B-tree split and parent lookup, with the goal of separating:

1. the point where an error pointer can be prevented from propagating; and
2. the point where the relevant error state first arises naturally.

I would appreciate feedback on whether these two hfs_bnode_find()
sites are the appropriate boundary for continued instrumentation, and
whether there are specific HFS+ B-tree invariants, parent-node state
transitions, or error-propagation rules around
hfs_bnode_split()/parent lookup that should be checked next.

#syz test

The 40P diagnostic patch is attached as plain text so its whitespace
is preserved reliably.

Thanks,
David Maximiliano Hermitte

--000000000000602a38065ba9b07e
Content-Type: application/octet-stream; 
	name="VQBIT_HFSPLUS_40P_DIAGNOSTIC.patch"
Content-Disposition: attachment; 
	filename="VQBIT_HFSPLUS_40P_DIAGNOSTIC.patch"
Content-Transfer-Encoding: base64
Content-ID: <>
X-Attachment-Id: 

LS0tIGEvZnMvaGZzcGx1cy9icmVjLmMKKysrIGIvZnMvaGZzcGx1cy9icmVjLmMKQEAgLTE1OCw3
ICsxNTgsMTkgQEAKIAkJCWhmc19idHJlZV9pbmNfaGVpZ2h0KHRyZWUpOwogCQkJbmV3X25vZGUt
PnBhcmVudCA9IHRyZWUtPnJvb3Q7CiAJCX0KLQkJZmQtPmJub2RlID0gaGZzX2Jub2RlX2ZpbmQo
dHJlZSwgbmV3X25vZGUtPnBhcmVudCk7CisJCXsKKwkJCXN0cnVjdCBoZnNfYm5vZGUgKnBhcmVu
dDsKKworCQkJcGFyZW50ID0gaGZzX2Jub2RlX2ZpbmQodHJlZSwgbmV3X25vZGUtPnBhcmVudCk7
CisJCQlpZiAoSVNfRVJSKHBhcmVudCkpIHsKKwkJCQlpbnQgZXJyID0gUFRSX0VSUihwYXJlbnQp
OworCisJCQkJZmQtPmJub2RlID0gTlVMTDsKKwkJCQloZnNfYm5vZGVfcHV0KG5ld19ub2RlKTsK
KwkJCQlyZXR1cm4gZXJyOworCQkJfQorCQkJZmQtPmJub2RlID0gcGFyZW50OworCQl9CiAKIAkJ
LyogY3JlYXRlIGluZGV4IGRhdGEgZW50cnkgKi8KIAkJY25pZCA9IGNwdV90b19iZTMyKG5ld19u
b2RlLT50aGlzKTsKQEAgLTQ2Miw3ICs0NzQsMTkgQEAKIAkJCWhmc19idHJlZV9pbmNfaGVpZ2h0
KHRyZWUpOwogCQkJbmV3X25vZGUtPnBhcmVudCA9IHRyZWUtPnJvb3Q7CiAJCX0KLQkJZmQtPmJu
b2RlID0gaGZzX2Jub2RlX2ZpbmQodHJlZSwgbmV3X25vZGUtPnBhcmVudCk7CisJCXsKKwkJCXN0
cnVjdCBoZnNfYm5vZGUgKnBhcmVudF9ub2RlOworCisJCQlwYXJlbnRfbm9kZSA9IGhmc19ibm9k
ZV9maW5kKHRyZWUsIG5ld19ub2RlLT5wYXJlbnQpOworCQkJaWYgKElTX0VSUihwYXJlbnRfbm9k
ZSkpIHsKKwkJCQlpbnQgZXJyID0gUFRSX0VSUihwYXJlbnRfbm9kZSk7CisKKwkJCQlmZC0+Ym5v
ZGUgPSBOVUxMOworCQkJCWhmc19ibm9kZV9wdXQobmV3X25vZGUpOworCQkJCXJldHVybiBlcnI7
CisJCQl9CisJCQlmZC0+Ym5vZGUgPSBwYXJlbnRfbm9kZTsKKwkJfQogCQkvKiBjcmVhdGUgaW5k
ZXgga2V5IGFuZCBlbnRyeSAqLwogCQloZnNfYm5vZGVfcmVhZF9rZXkobmV3X25vZGUsIGZkLT5z
ZWFyY2hfa2V5LCAxNCk7CiAJCWNuaWQgPSBjcHVfdG9fYmUzMihuZXdfbm9kZS0+dGhpcyk7Cg==
--000000000000602a38065ba9b07e--
