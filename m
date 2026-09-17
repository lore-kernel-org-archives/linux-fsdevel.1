Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25E4854E1
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634235; cv=none; b=LO0FWkbJMfa8xnBPRz2EpmfpROL5wnHbY+xqA7wxTLop9E2I/UPFFoIJAbca7mUHlpg9CbeKV53mMTBTVfOZl44g5RB0cXKw1W3oheUzGmFCAOVGN6xrkAHYplpIvPhojhH1y7TJ9iJYktCUPfgEbw0VAmRfqa/FaTyyz2IYM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634235; c=relaxed/simple;
	bh=oisXCmA2gqXKZ1tvx5HmoXhrxEPurs2e7HZrdYWEvUA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ZHIhQF2bH6omEpcqQCta4F1+dwVvL9Cg3SRfKZDL8DLFz+KRi3TOGR0Z9gQCVQbpxL0YOv8/IwAtaa5D+UyAul+DT0L454lOFz72YwdBcpSHoDS+WEzdsvvO4l0OogGW70+yWsWVru8K3AQCN4ZdlcagN5V756B9itOnh9XmmJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6c748676f6cso826199eaf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 01:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789634228; x=1790239028;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oisXCmA2gqXKZ1tvx5HmoXhrxEPurs2e7HZrdYWEvUA=;
        b=I3XEfmjEwjYM4FxTAYrkyWnPHW+XvCcyVRTizqZW06GvWa7Bhomzd9puwuHWQ3hWvQ
         lp9ItzPfv2TFidUJUd9D6iSu8Qml22bkA+VHcEXT5qQiv6bgRm47QuAFLZ2fh/ySUBaB
         dsjVZDRKjL7GpOR+UhLYEIad0TH9uhfaR7uyQJS9WSFLhg8NiiMsGcI7/4FHw9gptpfc
         B1ZP//5Pzg9uXd+D2Tx8uB4JZRYchrmBjr+BGrLPM9G0FHy3LQi2OYkhEynQkf3f9fGO
         C48wtfENNuiWkL7G2UsF+pMmgQn26rUe024KA1ydwE5tEpPcmsB5+dADBvLAgb97gkUN
         8OGQ==
X-Forwarded-Encrypted: i=1; AKwUvBydyjlxpeLGIe3qL76t6atmP756TuMQhVqR+OV7CatENfMNX7i2SotfsuH3dAOWAaY29HRNMj4upJXhBxS6@vger.kernel.org
X-Gm-Message-State: AFuF++l+4rvF7TnuOap4ytGEPmsSimHkvtsYpcbD5nAddLwcMWR5pzZ0
	jP5kST+yn2o99K3t+uy2Qd5lPK9v9iOPqq8bKe8Ltn4V2qqpMNZ8f5v+VyJJRH6FM2HJO+NoWXt
	CZyf58PulKkJTq5XodwMmve+TqUQc784uIKEHArpEBQSpNvV+dk+IHhYleaY=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1629:b0:6ae:8fc0:dbaf with SMTP id
 006d021491bc7-6c7d15ca0e3mr5732373eaf.1.1789634228189; Thu, 17 Sep 2026
 01:37:08 -0700 (PDT)
Date: Thu, 17 Sep 2026 01:37:08 -0700
In-Reply-To: <CADy8qZiJmfdwm11aV7z1mr+fjFJQ0kN8Wp6yBub0_0EP3uCssg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aaba6b4.71f81b7d.278072.001b.GAE@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in __hfsplus_brec_find
From: syzbot <syzbot+f957cf00261d1c41fafd@syzkaller.appspotmail.com>
To: davemadmaxxx@gmail.com
Cc: davemadmaxxx@gmail.com, frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com, 
	syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> Hi,
>
> I am investigating the HFS+ crash reported by syzbot in
> __hfsplus_brec_find() and would like to share the current results of a
> function-by-function reconstruction of the failure path.
>
> The public report shows the fault address:
>
> fffffffffffffffb
>
> On 64-bit Linux this value is consistent with the encoding of
> ERR_PTR(-EIO). I am treating that correspondence as an important clue,
> not as proof that -EIO originated at any particular call site.
>
> STATIC AUDIT
>
> The audit identified two concrete producer-to-consumer gaps in
> fs/hfsplus/brec.c. In both cases, hfs_bnode_find() can supply a value
> that is assigned to fd->bnode without an IS_ERR() check before
> fd->bnode is subsequently consumed as a struct hfs_bnode pointer.
>
> The first site is in hfs_brec_insert(), after a successful node split
> and during the parent-node lookup. A second related site exists in
> hfs_brec_update_parent().
>
> hfs_bnode_find() has error-return paths using ERR_PTR(), including
> -EIO. This makes error-pointer propagation through these unchecked
> assignments a mechanism worth testing. However, the existence of these
> paths alone does not establish that either site produced the error
> pointer in the original syzbot execution.
>
> RUNTIME REACHABILITY
>
> I then tested the relevant control flow in an isolated QEMU HFS+ environment.
>
> A clean HFS+ filesystem and a workload creating many long catalog
> names naturally caused a Catalog B-tree node split and reached the
> parent lookup in hfs_brec_insert(). No control-flow manipulation was
> needed to reach that branch.
>
> This established runtime reachability of the exact branch containing
> the first unchecked hfs_bnode_find() assignment.
>
> DIRECTED ERROR-POINTER EXPERIMENT
>
> Only after the natural control flow reached that parent-lookup point,
> I deliberately injected:
>
> fd->bnode = ERR_PTR(-EIO)
>
> The unprotected execution then faulted at:
>
> fffffffffffffffb
>
> This is the same numerical fault address shown in the public syzbot report.
>
> I want to be explicit about the interpretation of this experiment: the
> ERR_PTR(-EIO) value in this test was deliberately injected. Therefore
> this is NOT a natural reproduction of the syzbot bug and does NOT
> demonstrate that hfs_bnode_find() naturally returned -EIO in the
> original report.
>
> What the experiment demonstrates is narrower: if ERR_PTR(-EIO) reaches
> fd->bnode at this reachable producer-to-consumer gap, the resulting
> invalid pointer can produce the same fault-address value observed by
> syzbot.
>
> NAIVE CONTAINMENT AND CLEANUP BEHAVIOR
>
> An initial diagnostic attempt added an IS_ERR() check after assigning
> hfs_bnode_find() directly to fd->bnode and returned the corresponding
> error.
>
> That guard detected the injected -EIO, but the kernel subsequently
> faulted again at fffffffffffffffb, this time through the cleanup path
> ending in hfs_bnode_put().
>
> The reason was that fd->bnode still retained ERR_PTR(-EIO). The caller
> cleanup eventually executed hfs_find_exit(), which calls
> hfs_bnode_put(fd->bnode) without treating ERR_PTR as a valid state.
>
> This led to an additional source-level observation: fd->bnode appears
> to have an effective cleanup contract of containing either a valid
> hfs_bnode pointer or NULL, not an ERR_PTR value. Existing HFS+ code
> also contains a safe pattern in which the hfs_bnode_find() result is
> first held in a temporary pointer, checked with IS_ERR(), and only
> then assigned to fd->bnode.
>
> NEW_NODE OWNERSHIP
>
> The split path also has a live new_node reference returned by
> hfs_bnode_split(). Therefore simply returning on a failed parent
> lookup would not be sufficient; the diagnostic error exit must also
> account for that reference.
>
> DIAGNOSTIC PATCH 40P
>
> Based on those observations, I developed 40P as a diagnostic
> containment patch. It modifies the two unchecked hfs_bnode_find()
> sites identified in the audit.
>
> At each site, the hfs_bnode_find() result is first stored in a
> temporary pointer. If IS_ERR() is true, the patch:
>
> 1. obtains the error with PTR_ERR();
> 2. ensures fd->bnode is NULL rather than retaining the error pointer;
> 3. releases the live new_node reference with hfs_bnode_put(new_node);
> 4. returns the error;
> 5. assigns the temporary pointer to fd->bnode only after it has passed
> the error check.
>
> Under the same directed ERR_PTR(-EIO) condition, this diagnostic
> version contained the tested error-pointer propagation without leaving
> fd->bnode poisoned for the later cleanup path.
>
> 40P is a diagnostic patch only. It is not intended as an upstream fix.
> Its purpose is to test and constrain the causal path while preserving
> the local cleanup state observed in the source.
>
> CURRENT EVIDENCE BOUNDARY
>
> The evidence currently supports the following statements:
>
> - The public syzbot report contains the fault address fffffffffffffffb.
> - That value is consistent with ERR_PTR(-EIO).
> - Two unchecked hfs_bnode_find() -> fd->bnode producer-to-consumer
> gaps were identified in brec.c.
> - hfs_bnode_find() can return error pointers, including -EIO on an error path.
> - hfs_brec_insert() and the relevant post-split parent-lookup branch
> are naturally runtime-reachable in the controlled HFS+ workload.
> - A deliberately injected ERR_PTR(-EIO) at that reachable point
> produces the same numerical fault-address value.
> - A naive IS_ERR()+return is insufficient because fd->bnode can remain
> poisoned and be consumed during cleanup.
> - 40P contains that directed condition while maintaining fd->bnode as
> NULL on the tested error exit and releasing new_node.
>
> The evidence does NOT yet establish:
>
> - that the original syzbot execution naturally obtained -EIO from
> hfs_bnode_find() at this site;
> - that either of these two unchecked assignments is the complete root
> cause of the public crash;
> - or where the first naturally occurring invalid/error state
> originates in the syzbot execution.
>
> NEXT DIAGNOSTIC QUESTION
>
> I am continuing to move the observation point backward around the
> Catalog B-tree split and parent lookup, with the goal of separating:
>
> 1. the point where an error pointer can be prevented from propagating; and
> 2. the point where the relevant error state first arises naturally.
>
> I would appreciate feedback on whether these two hfs_bnode_find()
> sites are the appropriate boundary for continued instrumentation, and
> whether there are specific HFS+ B-tree invariants, parent-node state
> transitions, or error-propagation rules around
> hfs_bnode_split()/parent lookup that should be checked next.
>
> #syz test

This crash does not have a reproducer. I cannot test it.

>
> The 40P diagnostic patch is attached as plain text so its whitespace
> is preserved reliably.
>
> Thanks,
> David Maximiliano Hermitte
