Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA8833D4E2
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001187; cv=pass; b=UIzfJab5pdNeJeBHUrGkROE1QzBlScD12AiQhwNYlK2F4d/1MfWrtDGcwwv+RvZ8L2RdA4iw9nxZ3m0DrLDbKd70P5nZM5d8ZpMhmrJpiIjIYAwGBgJw+0ayueXznoeXVtLLDjYTyQdqxl3/SQOXxnSXvL9/ydboEz6/p2fGOow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001187; c=relaxed/simple;
	bh=EDJNvm0YrjeMnSgMUb+fvcef3p2ZkXve5QJOezV7E5A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EHSwRbdRiu3K33U28j4dxfxEVKkhEFhTU/Eyx49qWJguSrPrWhC37XSEnyNsibTw5sffj1jUnud9zJ6txQgOaMJStgb075w06+CSg5p+FWexnFmtVeObyr6HwdC/Fg4CdL2AiaiUD8Lkv3g7dOsG8XbmdJcErfR6ePZLVywGqvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=uQCt9oHQ; arc=pass smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="uQCt9oHQ"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7c307937816so125730327b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 13:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780001185; cv=none;
        d=google.com; s=arc-20240605;
        b=Wyt2FmLRIhK/d7bYFM5DD6McqoOc3FUgdegHOsl7rlGomB9NqqYQqJ/a7v7nO5wv/K
         FVnM7skfLLeh2anPiG7bV1Kgg6CD+tzIe9VXeTny08j1sK3u04xpfyKoXy24dhAlgwRj
         w4A0ScJMP2reYcmEACjxHV6X6qjcCiuxcqvHPmzFuhXm0avOH63eXutZI6QQkdaVocF0
         KoZMnJ6J9INWYuY8MjsAJPMA0wQK9mUiLZJffrd9GsW3ryMCx7dthGSdUM0LhCqDf7SU
         xvDEdlribt286SNljjPC9tzfUT+cDpKPsf5Y024+KhDJeWgFOixN34dsrollvdAedvp7
         Yvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HjgfqX7QNXnSnP3koXPVYHPRxEus+HDmNJT6HKYumdw=;
        fh=AE02y6zOJc/d+TI8j3MIr8TfWz8Dz+J0+AC2URkahbY=;
        b=Chdrxf2y6uo82QZUYqyiAqA3ro35GA91md8WkNRLIGxJNZksTse6+4reQvvisQjE5m
         xVHp4IVadF/e6wo605CmTu0NNHbjU2o3ey3RhS0Zzj4vwwUGZQMlFVOexyXISNVThvoK
         3RV/lSigWvKBLSPAJQ3ZDKqrXYhIxfNDltdlqU/fYwbB5ituvEq22PMGpKRsmV/ltvSa
         CTC1P2pfDIbQpGI0OrOWRw+gQDHxZJwlx9wSeySOydGtvOX+gArhKZQ7IkoLjAKEpxoG
         CdMnbuRMmM6hUt83wF70NVncIcj2F1vtmaaTum8yGa7vkD4hMQ+onwGzmCdVkiltOH00
         BkbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1780001185; x=1780605985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HjgfqX7QNXnSnP3koXPVYHPRxEus+HDmNJT6HKYumdw=;
        b=uQCt9oHQV8DgKWXnMiAA6TJKZxzm1RefCNVZNFw0GfDi3Dt1cN8D9mFUKrklMbdrx2
         aCcJ06bu3QxBSgCN8Ghn7dYyzyAfKvBcvmki5IxPaCqeDQ2s7TxEQvhemYnO3SfCyBm6
         3IgLn2gWDlBEwQ1AkRHVBDAyxdj27SiY1B4/gzBilRnXEdJHoTtojTKAFSury1PRUCZS
         LTYsDIhjv5T1wVNZz1xcFE9II0D0xt0bdbkv+zdHR8n9D4VkqW8KY9o13QxpP3kykve/
         bC3klbAGxGRDDe1JCQaRizH19qpueIpYCh3DoIFi/5TX+7CQ1kaNue3S4fHYiqKLjPgk
         6qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001185; x=1780605985;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjgfqX7QNXnSnP3koXPVYHPRxEus+HDmNJT6HKYumdw=;
        b=qLciYcVJSP9uJHp6tzD42XqDn7b+v5M1ki0hKIRMtXIFHapKZhuvfOcYdOzexc3HCC
         RSFNIiubMsNRmQIa6NMdtluCf5NKpT0GMclxZi3Yldgcwcqmog9plQ/UQ4FVpqtKDFnl
         xOh/pYqPnwGRijCLUnxHtrdoSeQxV3lrIPv/vxBHFEV2Cl0xoxxVg1uHVWzYm/54bHnj
         wdOocxYNMqGcJReQqDWBboF/kfKaW6k+f8V7XNdUMVtUs6C3cyei3aoQpWg0mz9m8ZtT
         bLYj6iEXHtq6vSYNYTMuiXBT4kG7pi6OblsyDH+l/CTLm218aAujjkZ1clf8Dwu2baxP
         Ci8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9REQ8plSDBrS8FB7+wEqofKx8UgaIzdDrYJuWE5gmIXo53HKEuR4hB1yER3oyssFss6vS3mbp1Hvnc4jHy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk2cpYGSfL0gjNFwzRlak6eUAgdIwJNaYjyM0Obufi9ZdsjTnt
	swP5fPvVudCowX100vRoF7T1iV+mXE2LH6W/j3jsFnpSA4pZk1p595z70RJV4wFQ8rkac2SgE2M
	j9uw0v63rIk7UYe9GU5u/qpUXitBVJhiFRsW0omlq
X-Gm-Gg: Acq92OHuVP7+GpYtQnQjQ5Zdt02DXTAPT+1KmCsNG7YFyNjsbonOY4Y9HDj1LQvajpt
	B+TUwyz7ONydpTSvqOYLvQO4TAEJTwZu+IMF1LtTE1CvDY2aCia1QQ6ZYgaxzG0GyF/I+pyfvqg
	p6uitPHpoLHvYqmsTYu86CdIEID5b+c+w9zuKSDFespB/IJtqfYmk7XE6HzqbANLGR2MMhpWB0U
	9C5+ssnZ+6Ymgy3fY83eG5fnTOUE421OW/VXPFFbabxNeunN8DQoVZE0EFMLUtKXF633FxJqLiI
	MbyhBmB9C8NA/BWwlA==
X-Received: by 2002:a05:690c:c4c1:b0:7bd:a4dc:c22a with SMTP id
 00721157ae682-7ddc5519b99mr8715477b3.48.1780001183678; Thu, 28 May 2026
 13:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Thu, 28 May 2026 13:46:12 -0700
X-Gm-Features: AVHnY4JAj-3VfYypeFJ7wOHjZcqEp9eB_RGlPOsLE8_Y8Dvn9TOd4zDJQpub1m4
Message-ID: <CA+0ovCjP5N=37oRM53FfXZbZ7dRgTcJ1_kpT1JGxB55Npnr7TA@mail.gmail.com>
Subject: [BUG] gfs2: list_del corruption of i_rwsem.wait_list during unlinkat
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000041f9460652e6d211"

--00000000000041f9460652e6d211
Content-Type: text/plain; charset="UTF-8"

Hello Andreas and locking/gfs2 maintainers,

I am reporting a DEBUG_LIST list_del corruption on a gfs2 unlinkat()
path found by syzkaller. The slab the kernel implicates is gfs2_inode,
but the corrupted list is the rw_semaphore's own wait_list, so I am
Cc'ing the locking maintainers as well.

Summary:
On a contended unlinkat() against an inode on a mounted gfs2 image,
do_unlinkat() takes the target inode's i_rwsem via inode_lock_nested(),
falls into rwsem_down_write_slowpath(), and reaches
rwsem_try_write_lock(). The list_del(&waiter->list) at
kernel/locking/rwsem.c:662 (on v6.17.8) trips DEBUG_LIST in
__list_del_entry_valid_or_report() at lib/list_debug.c:62. The kernel
prints:

  slab gfs2_inode start ffff8881283f9aa0 pointer offset 304 size 1576
  list_del corruption. prev->next should be ffffc900075ffc40, but was
ffff8881283f9bd0. (prev=ffff8881283f9bd0)

The trapping entry is the queued waiter at ffffc900075ffc40; the
prev pointer it carries names slab+304 = ffff8881283f9bd0; and the
printed prev->next equals that same address (i.e. prev == prev->next).
Since list_del at kernel/locking/rwsem.c:662 operates on a waiter
queued on the rwsem's wait_list (rwsem_waiter carries no other list
membership in v6.17), and waiters live on the stack of the blocked
task, the prev pointer being in the gfs2_inode slab identifies
slab+304 as the i_rwsem.wait_list head itself.

Observed on:
- Linux 6.17.8, x86_64, QEMU Q35
- KASAN + DEBUG_LIST enabled
- Crash context: Comm: syz.2.171, PID 4766
- Reached on the fuzzed unlinkat() path: inode_lock_nested ->
  down_write_nested -> rwsem_down_write_slowpath ->
  rwsem_try_write_lock -> list_del(&waiter->list)
- As the fuzzer didn't have a reproducer for this,
  I have NOT verified this bug against linus/master at commit
  e8c2f9fdadee (v7.1-rc4-754-ge8c2f9fdadee); the relevant
  data structure was restructured in commit 1ea4b473504b
  ("locking/rwsem: Remove the list_head from struct rw_semaphore",
  Matthew Wilcox (Oracle), 2026-03-05, first appearing in v7.1-rc1).
  After that commit struct rw_semaphore no longer contains a
  list_head wait_list; waiters are linked via sem->first_waiter
  plus inter-waiter waiter->list.

Impact:
A user with the privileges to mount a gfs2 image and perform an
unlinkat() on a contended path trips kernel BUG, killing the kernel.
The full Oops header, register dump, and call trace are in
crash-report.txt. The trapping RIP is
__list_del_entry_valid_or_report+0x15a/0x190 (lib/list_debug.c:62);
the kernel BUG fires at lib/list_debug.c:64.

Expected behavior:
Either the rwsem's wait_list invariant (no list_del observing a
self-referencing prev while a waiter is queued) was violated, or an
overlapping lifecycle operation on the gfs2_inode placed the rwsem
into an inconsistent state. The maintainers are best placed to
identify the root cause.

Reproducer:
A standalone .syz or C reproducer was not produced for this seed;
the crash fired during automated gfs2 unlink fuzzing. The console
report is attached as crash-report.txt.

Novelty check:
I searched the syzbot dashboard's upstream open, fixed, stable, and
invalid (per-subsystem gfs2/locking/fs) namespaces, the Android
dashboard, and the marc.info linux-kernel archive, for
"__list_del_entry_valid_or_report" + "rwsem", "list_del corruption"
+ "gfs2_inode", "rwsem_try_write_lock" + "gfs2", "rwsem" +
"wait_list" + "corruption", and "corrupted list in do_unlinkat". I
did not find an exact match. The adjacent gfs2 + do_unlinkat tickets
in the invalid namespace are task-hung / soft-lockup / deadlock
variants, not DEBUG_LIST list_del trips. The adjacent
__list_del_entry_valid_or_report ticket is a KCSAN data-race in
nfc_llcp_register_device, a different code path.


I appreciate your time and consideration, and I'm grateful for your
work on this subsystem. I'd be glad to test any candidate patches.

Regards,

--00000000000041f9460652e6d211
Content-Type: text/plain; charset="US-ASCII"; name="crash-report.txt"
Content-Disposition: attachment; filename="crash-report.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mppygz770>
X-Attachment-Id: f_mppygz770

IHNsYWIgZ2ZzMl9pbm9kZSBzdGFydCBmZmZmODg4MTI4M2Y5YWEwIHBvaW50ZXIgb2Zmc2V0IDMw
NCBzaXplIDE1NzYKbGlzdF9kZWwgY29ycnVwdGlvbi4gcHJldi0+bmV4dCBzaG91bGQgYmUgZmZm
ZmM5MDAwNzVmZmM0MCwgYnV0IHdhcyBmZmZmODg4MTI4M2Y5YmQwLiAocHJldj1mZmZmODg4MTI4
M2Y5YmQwKQotLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0Ka2VybmVsIEJVRyBh
dCBsaWIvbGlzdF9kZWJ1Zy5jOjY0IQpPb3BzOiBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFNN
UCBLQVNBTiBOT1BUSQpDUFU6IDAgVUlEOiAwIFBJRDogNDc2NiBDb21tOiBzeXouMi4xNzEgTm90
IHRhaW50ZWQgNi4xNy44ICMxIFBSRUVNUFQoZnVsbCkgCkhhcmR3YXJlIG5hbWU6IFFFTVUgU3Rh
bmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIDEuMTYuMy1kZWJpYW4tMS4xNi4zLTIg
MDQvMDEvMjAxNApSSVA6IDAwMTA6X19saXN0X2RlbF9lbnRyeV92YWxpZF9vcl9yZXBvcnQrMHgx
NWEvMHgxOTAgbGliL2xpc3RfZGVidWcuYzo2MgpDb2RlOiBlOCA1YiBjYiBmZSBmZCA0MyA4MCAz
YyAyYyAwMCA3NCAwOCA0YyA4OSBmZiBlOCBhYyA5ZiAxYSBmZSA0OSA4YiAxNyA0OCBjNyBjNyBh
MCAyYSA5OCA4NiA0OCA4OSBkZSA0YyA4OSBmOSBlOCBlNyBkOSA1OSBmZCA5MCA8MGY+IDBiIDRj
IDg5IGY3IGU4IDJjIGNiIGZlIGZkIDQzIDgwIDNjIDJjIDAwIDc0IDA4IDRjIDg5IGZmIGU4IDdk
ClJTUDogMDAxODpmZmZmYzkwMDA3NWZmYWQwIEVGTEFHUzogMDAwMTAwNDYKUkFYOiAwMDAwMDAw
MDAwMDAwMDZkIFJCWDogZmZmZmM5MDAwNzVmZmM0MCBSQ1g6IGQyZWI0M2I3NzZmZjFiMDAKUkRY
OiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDA4MDAwMDAwMiBSREk6IDAwMDAwMDAwMDAw
MDAwMDAKUkJQOiBmZmZmYzkwMDA3NWZmZDEwIFIwODogZmZmZjg4ODIzNWMyNDBkMyBSMDk6IDFm
ZmZmMTEwNDZiODQ4MWEKUjEwOiBkZmZmZmMwMDAwMDAwMDAwIFIxMTogZmZmZmVkMTA0NmI4NDgx
YiBSMTI6IDFmZmZmMTEwMjUwN2YzN2EKUjEzOiBkZmZmZmMwMDAwMDAwMDAwIFIxNDogZmZmZjg4
ODEyODNmOWJkMCBSMTU6IGZmZmY4ODgxMjgzZjliZDAKRlM6ICAwMDAwN2Y5ODlkNjU1NmMwKDAw
MDApIEdTOmZmZmY4ODgyYWJiZTgwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApDUzog
IDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkNSMjogMDAwMDdm
ZmU4ZDg2ZGY4MCBDUjM6IDAwMDAwMDAxMWRhNDYwMDAgQ1I0OiAwMDAwMDAwMDAwNzUwZWYwClBL
UlU6IDgwMDAwMDAwCkNhbGwgVHJhY2U6CiA8VEFTSz4KIF9fbGlzdF9kZWxfZW50cnlfdmFsaWQg
aW5jbHVkZS9saW51eC9saXN0Lmg6MTI0IFtpbmxpbmVdCiBfX2xpc3RfZGVsX2VudHJ5IGluY2x1
ZGUvbGludXgvbGlzdC5oOjIxNSBbaW5saW5lXQogbGlzdF9kZWwgaW5jbHVkZS9saW51eC9saXN0
Lmg6MjI5IFtpbmxpbmVdCiByd3NlbV90cnlfd3JpdGVfbG9jayBrZXJuZWwvbG9ja2luZy9yd3Nl
bS5jOjY2MiBbaW5saW5lXQogcndzZW1fZG93bl93cml0ZV9zbG93cGF0aCsweDk0ZS8weDEwNDAg
a2VybmVsL2xvY2tpbmcvcndzZW0uYzoxMTU5CiBfX2Rvd25fd3JpdGVfY29tbW9uIGtlcm5lbC9s
b2NraW5nL3J3c2VtLmM6MTMxNyBbaW5saW5lXQogX19kb3duX3dyaXRlIGtlcm5lbC9sb2NraW5n
L3J3c2VtLmM6MTMyNiBbaW5saW5lXQogZG93bl93cml0ZV9uZXN0ZWQrMHgxY2IvMHgyMTAga2Vy
bmVsL2xvY2tpbmcvcndzZW0uYzoxNzA3CiBpbm9kZV9sb2NrX25lc3RlZCBpbmNsdWRlL2xpbnV4
L2ZzLmg6OTE2IFtpbmxpbmVdCiBkb191bmxpbmthdCsweDFkYy8weDU5MCBmcy9uYW1laS5jOjQ2
NDUKIF9fZG9fc3lzX3VubGlua2F0IGZzL25hbWVpLmM6NDY5OSBbaW5saW5lXQogX19zZV9zeXNf
dW5saW5rYXQgZnMvbmFtZWkuYzo0NjkyIFtpbmxpbmVdCiBfX3g2NF9zeXNfdW5saW5rYXQrMHhk
OC8weGYwIGZzL25hbWVpLmM6NDY5MgogZG9fc3lzY2FsbF94NjQgYXJjaC94ODYvZW50cnkvc3lz
Y2FsbF82NC5jOjYzIFtpbmxpbmVdCiBkb19zeXNjYWxsXzY0KzB4ZjAvMHgzOTAgYXJjaC94ODYv
ZW50cnkvc3lzY2FsbF82NC5jOjk0CiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3
Ny8weDdmClJJUDogMDAzMzoweDdmOTg5ZWM0Nzc4ZApDb2RlOiBmZiBjMyA2NiAyZSAwZiAxZiA4
NCAwMCAwMCAwMCAwMCAwMCA5MCBmMyAwZiAxZSBmYSA0OCA4OSBmOCA0OCA4OSBmNyA0OCA4OSBk
NiA0OCA4OSBjYSA0ZCA4OSBjMiA0ZCA4OSBjOCA0YyA4YiA0YyAyNCAwOCAwZiAwNSA8NDg+IDNk
IDAxIGYwIGZmIGZmIDczIDAxIGMzIDQ4IGM3IGMxIGIwIGZmIGZmIGZmIGY3IGQ4IDY0IDg5IDAx
IDQ4ClJTUDogMDAyYjowMDAwN2Y5ODlkNjU1MDE4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6
IDAwMDAwMDAwMDAwMDAxMDcKUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDdmOTg5ZWVk
NjE4MCBSQ1g6IDAwMDA3Zjk4OWVjNDc3OGQKUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAw
MDIwMDAwMDAzOThjMCBSREk6IGZmZmZmZmZmZmZmZmZmOWMKUkJQOiAwMDAwN2Y5ODllY2VlYjNk
IFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDAKUjEwOiAwMDAwMDAw
MDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwMDAwMDAwMDAKUjEz
OiAwMDAwN2Y5ODllZWQ2MjE4IFIxNDogMDAwMDdmOTg5ZWVkNjE4MCBSMTU6IDAwMDA3ZmZlOGQ4
NmU4NTAKIDwvVEFTSz4KTW9kdWxlcyBsaW5rZWQgaW46Ci0tLVsgZW5kIHRyYWNlIDAwMDAwMDAw
MDAwMDAwMDAgXS0tLQpSSVA6IDAwMTA6X19saXN0X2RlbF9lbnRyeV92YWxpZF9vcl9yZXBvcnQr
MHgxNWEvMHgxOTAgbGliL2xpc3RfZGVidWcuYzo2MgpDb2RlOiBlOCA1YiBjYiBmZSBmZCA0MyA4
MCAzYyAyYyAwMCA3NCAwOCA0YyA4OSBmZiBlOCBhYyA5ZiAxYSBmZSA0OSA4YiAxNyA0OCBjNyBj
NyBhMCAyYSA5OCA4NiA0OCA4OSBkZSA0YyA4OSBmOSBlOCBlNyBkOSA1OSBmZCA5MCA8MGY+IDBi
IDRjIDg5IGY3IGU4IDJjIGNiIGZlIGZkIDQzIDgwIDNjIDJjIDAwIDc0IDA4IDRjIDg5IGZmIGU4
IDdkClJTUDogMDAxODpmZmZmYzkwMDA3NWZmYWQwIEVGTEFHUzogMDAwMTAwNDYKUkFYOiAwMDAw
MDAwMDAwMDAwMDZkIFJCWDogZmZmZmM5MDAwNzVmZmM0MCBSQ1g6IGQyZWI0M2I3NzZmZjFiMDAK
UkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDA4MDAwMDAwMiBSREk6IDAwMDAwMDAw
MDAwMDAwMDAKUkJQOiBmZmZmYzkwMDA3NWZmZDEwIFIwODogZmZmZjg4ODIzNWMyNDBkMyBSMDk6
IDFmZmZmMTEwNDZiODQ4MWEKUjEwOiBkZmZmZmMwMDAwMDAwMDAwIFIxMTogZmZmZmVkMTA0NmI4
NDgxYiBSMTI6IDFmZmZmMTEwMjUwN2YzN2EKUjEzOiBkZmZmZmMwMDAwMDAwMDAwIFIxNDogZmZm
Zjg4ODEyODNmOWJkMCBSMTU6IGZmZmY4ODgxMjgzZjliZDAKRlM6ICAwMDAwN2Y5ODlkNjU1NmMw
KDAwMDApIEdTOmZmZmY4ODgyYWJiZTgwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApD
UzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkNSMjogMDAw
MDdmZmU4ZDg2ZGY4MCBDUjM6IDAwMDAwMDAxMWRhNDYwMDAgQ1I0OiAwMDAwMDAwMDAwNzUwZWYw
ClBLUlU6IDgwMDAwMDAwCgo8PDw8PDw8PDw8PDw8PDwgdGFpbCByZXBvcnQgPj4+Pj4+Pj4+Pj4+
Pj4+Cgo=
--00000000000041f9460652e6d211--
