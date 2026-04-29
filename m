Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A853E3A8FF7
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471571; cv=none; b=DJzlNA6YDkX9Eyhh3Rw5FAbxt1dXKZy+PkAgw6/WKHHyxnchP1pbjqnL2iKBq84PspM89CqvqcwnXRyBx0E4e6rAicvO1HcTcE5cs33OcLI3OFQjHlqBDCh+eCLhk3a/laKu4bwJF4+cNnZr/BZr1sHWkcuM7+k0ivXA6ngSoYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471571; c=relaxed/simple;
	bh=uExTrrXv2ZF9hJiGpeUeEqQ4gYyS1a0Vzka3f+QUJXw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=U4H6Jq0mT6auyLE4LQkMBYCEaDAvExWdow2MIQxBSCRr8ISX+g0HDCWm6JSx4KP562MfadlrCW1D+H10WYQm/d3iQyek0azCrQgP7xMAUZU4yVsDCWeazU9gJKS4V2w1oGMkO3aDkEFH89xk3vyhDB29xZ2y31x2MxdzXy2c9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=PMsvEJkb; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PMsvEJkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1777471557; x=1777730757;
	bh=HBA+prfYWAXuk4JZntWYfoOHN1pxfrVekP+qEbg6iDY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PMsvEJkbQaYqAVIwHRtjSMFXJxBZAQ4RTAisXPFiCkx9YCdWUTEexdcpwx8xGzWh/
	 brNk05b31Xe7CGpfSC5wrXfxTIIrWxmLJKf6XpK9vRjXzN85GkC0+eurqqvVfmMqMm
	 eKNjvagdnr/4TdtGjRcqSxXyBz2r8uKHtqg9gL8TbMpmgC7G1QStKh14kmLlOur1M8
	 X6RHaz7d+CTEf9Q0bfGCW+CfN+EkgvMFH5wdP+Bu2Y0kFXvQnxovZgxCmAgCUGfQxp
	 mORv1K5HWK/QGxXCRelqzyQqnBOWhxnSBi/ZmjQn5UbzGYMUEFzKBzMZ4+uMf4drqp
	 /uyDWp3Sgte7Q==
Date: Wed, 29 Apr 2026 14:05:48 +0000
To: david.laight.linux@gmail.com, riel@surriel.com, perry.yuan@amd.com, jgross@suse.com, ljs@kernel.org, justinstitt@google.com, hpa@zytor.com, shuah@kernel.org, nathan@kernel.org, sohil.mehta@intel.com, mathieu.desnoyers@efficios.com, brauner@kernel.org, ethantidmore06@gmail.com, dave.hansen@linux.intel.com, maciej.wieczor-retman@intel.com, mingo@redhat.com, bp@alien8.de, akpm@linux-foundation.org, peterz@infradead.org, viro@zeniv.linux.org.uk, superman.xpt@gmail.com, rdunlap@infradead.org, aliceryhl@google.com, ilpo.jarvinen@linux.intel.com, david@kernel.org, xin@zytor.com, seanjc@google.com, tglx@kernel.org, houwenlong.hwl@antgroup.com, yury.norov@gmail.com, rppt@kernel.org, oleg@redhat.com, nick.desaulniers+lkml@gmail.com, vmalik@redhat.com, morbo@google.com, ryan.roberts@arm.com, kees@kernel.org
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, m.wieczorretman@pm.me
Subject: [PATCH v7 0/4] x86: Simplifying LAM
Message-ID: <cover.1777470980.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 5d54fa1e5d74e57302a3cd6663e845502b4d8fb5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

After ChkTag [1] announcement, it's worth preparing a stable x86 linear
address masking (lam) user interface. One important aspect of lam is the
tag width, and aligning it with other industry solutions can provide a
more popular, generalized interface that other technologies could
utilize.

ChkTag will use 4-bit tags and since that's the direction other memory
tagging implementations seem to be taking too (for example Arm's MTE)
it's reasonable to converge lam in linux to the same specification. Even
though x86's LAM supports 6-bit tags it is beneficial to shorten lam to
4 bits as ChkTag will likely be the main user of the interface and such
connection should simplify things in the long run.

Change in the interface tries to cover the three following aspects:
=09- Have the kernel use the same tag width as the underlying
=09  hardware does. This should ensure consistent treatment of user
=09  pointers across various user/kernel interfaces.
=09- Present the user with a stable tag width value not dependent
=09  on the maximum capabilities of the hardware used. This should
=09  prevent any backward capability issues in case there are any
=09  hardware changes in the future.
=09- Export the hardware tag width through procfs for programs that
=09  need to recreate kernel's treatment of user pointers
=09  accurately such as gdb.

Changing the tag width at the moment has no effect on userspace
programs. Due to LAM being disabled until LASS is fully supported in the
kernel there are yet no userspace projects relying on a specific LAM tag
width. One known exception is the clang compiler and its hwasan support.
It is however not a problem since there are both no users of hwasan on
x86 yet and upon closer inspection (when working on x86 KASAN software
tag-based mode) I found it's not working correctly and needs to be
patched.

The patchset also cleans up some comments referencing LAM_U48 which was
not implemented in the kernel and the comments shouldn't imply it can be
enabled.

Patches are based on v7.1-rc1

Changelog v7:
- Redid quite a bit after Rick Edgecombe pointing out the inconsistent
  treatment of user pointers internally.
- Cover letter:
=09- Added the third paragraph to the cover letter summarizing expected
  =09  results of the interface changes.
- 1/4:
=09- Redid the untag mask handling and syscall return. Updated last
=09  paragraph of the patch message.
- 2/4:
=09- Added a procfs patch to help make gdb like programs work with
=09  LAM.
- 3/4:
=09- No changes
- 4/4:
=09- Made the selftest constants analogous to the kernel ones.

Changelog v6:
- 1/3
=09- Change define names so they match the arch_prctl() cases for
=09  LAM.
=09- Add more defines so they build into the GENMASK() more
=09  properly.
- 2/3
=09- Add one reviewed-by.
- 3/3
=09- Update the patch subject after removing additional test cases
=09  during v3.
=09- Change bit width and untag mask defines so they match the
=09  kernel ones in name and add GENMASK() to x86 selftests so
=09  they match the kernel in form. Update the patch description.

Changelog v5:
- Rebase onto v7.0-rc7.

Changelog v4:
- Remove the 'default' wording from the cover letter and patch messages.
- Add a paragraph to the cover letter about userspace impact.

Changelog v3:
- Remove the debugfs part and update the rest of the code and patch
  messages accordingly.

Changelog v2:
- Extend a char buffer in debugfs read callback to fit the format
  string.

[1] https://community.intel.com/t5/Blogs/Tech-Innovation/open-intel/ChkTag-=
x86-Memory-Safety/post/1721490

Maciej Wieczor-Retman (4):
  x86/process: Shorten the LAM tag width
  x86/process: Add a procfs file with hardware address masking
  x86/mm: Cleanup comments where LAM_U48 is mentioned
  selftests/lam: Update LAM tag width and cleanup names

 arch/x86/Kconfig                  |  1 +
 arch/x86/include/asm/mmu.h        |  2 +-
 arch/x86/include/asm/tlbflush.h   |  2 +-
 arch/x86/kernel/process_64.c      | 30 ++++++++--
 fs/proc/Kconfig                   |  4 ++
 fs/proc/base.c                    |  6 ++
 include/linux/uaccess.h           |  5 ++
 tools/testing/selftests/x86/lam.c | 94 ++++++++++++++++---------------
 8 files changed, 92 insertions(+), 52 deletions(-)

--=20
2.53.0


