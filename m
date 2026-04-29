Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F712C0F6C;
	Wed, 29 Apr 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471601; cv=none; b=DwHeVwregg/qIy2Cbt4daGOWyIlSbmlKPg9F/pqI2QlUOuxPtl3Wh0OiZGVedI2Vo9ruqri4t2rVDqRfLVL0JL8Z6mWUOQUBVy7a6mhLeFlZ56CRGltzpNDqA44PPcgyb02FK3gvN/xfAesopkoNkAyOMUtnMKKtqkhtktM/qnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471601; c=relaxed/simple;
	bh=a2pHJs2qA0ZtKDeSchRhJe00tuLQzf19+B4gHWLiYxc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMEaemwL4LK4nq8TBHE5Ih7zei/iieBdRzHD2Y/29pIRjreFXbUTl3m/C5HHR165+if6EHEmcs1V5gYOExySM1c6rCTaJowLfGSTYSytyRscr1Is1I/wueh8wC0wB+f2P1y9HEorGVC/OcJzmdYTZvUkjq5h9uPR23/5tDIvlCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CE9GM1bI; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CE9GM1bI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1777471583; x=1777730783;
	bh=O068SfSii2/1GBWY8nC2eioHN+7tVaZriZSWNDGm94o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CE9GM1bIOPv10JF3xL+Z1wzMarIBjQnAhgInRZFDwkbUm1j2Ipbe5o8Em1gsNKRb5
	 aSSlQlE+B9iWk8Bgwbar61BQUZCMUffvBzeO/D+1l1KkTOUTlrtB2TmglHp+85XUyu
	 ywpvcdOQthA6Cnxhjol7QN75SYYkhuWESR10W14MLWatfp+QPordSSO/bWHd5YxkTq
	 ZKVsBCdl8AHAQ+vgfLFxeVENHjuAJw0UjhcOXLQ7Fy946TtFMZQUnAEvl7vrProb6B
	 44NXhqA2vFXl8qDsQ+hBUB27lYJFOVeF0iDfpuQKjEjbquWMsGonQYb74ZkNmgihBi
	 j4oiAeWBD900Q==
Date: Wed, 29 Apr 2026 14:06:19 +0000
To: david.laight.linux@gmail.com, riel@surriel.com, perry.yuan@amd.com, jgross@suse.com, ljs@kernel.org, justinstitt@google.com, hpa@zytor.com, shuah@kernel.org, nathan@kernel.org, sohil.mehta@intel.com, mathieu.desnoyers@efficios.com, brauner@kernel.org, ethantidmore06@gmail.com, dave.hansen@linux.intel.com, maciej.wieczor-retman@intel.com, mingo@redhat.com, bp@alien8.de, akpm@linux-foundation.org, peterz@infradead.org, viro@zeniv.linux.org.uk, superman.xpt@gmail.com, rdunlap@infradead.org, aliceryhl@google.com, ilpo.jarvinen@linux.intel.com, david@kernel.org, xin@zytor.com, seanjc@google.com, tglx@kernel.org, houwenlong.hwl@antgroup.com, yury.norov@gmail.com, rppt@kernel.org, oleg@redhat.com, nick.desaulniers+lkml@gmail.com, vmalik@redhat.com, morbo@google.com, ryan.roberts@arm.com, kees@kernel.org
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, m.wieczorretman@pm.me
Subject: [PATCH v7 3/4] x86/mm: Cleanup comments where LAM_U48 is mentioned
Message-ID: <b39975baea136f2fb626dfef348fb449d2bab086.1777470980.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1777470980.git.m.wieczorretman@pm.me>
References: <cover.1777470980.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: c68e4a056c7e01688112f271db25ca9fe6c5b228
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

For simplicity only the LAM_U57 mode is implemented in the kernel. No
matter whether the enabled paging mode is 5-level or 4-level the masked
tag bits are the same as on a 5-level system.

Remove two mentions of LAM_U48 which implied that it could be enabled.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
---
Changelog v6:
- Add Sohil's Reviewed-by.

 arch/x86/include/asm/mmu.h      | 2 +-
 arch/x86/include/asm/tlbflush.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 0fe9c569d171..9dcfce439c19 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -49,7 +49,7 @@ typedef struct {
 =09unsigned long flags;
=20
 #ifdef CONFIG_ADDRESS_MASKING
-=09/* Active LAM mode:  X86_CR3_LAM_U48 or X86_CR3_LAM_U57 or 0 (disabled)=
 */
+=09/* Active LAM mode: X86_CR3_LAM_U57 or 0 (disabled) */
 =09unsigned long lam_cr3_mask;
=20
 =09/* Significant bits of the virtual address. Excludes tag bits. */
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflus=
h.h
index 5a3cdc439e38..94c5ca1febaf 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -110,7 +110,7 @@ struct tlb_state {
 =09/*
 =09 * Active LAM mode.
 =09 *
-=09 * X86_CR3_LAM_U57/U48 shifted right by X86_CR3_LAM_U57_BIT or 0 if LAM
+=09 * X86_CR3_LAM_U57 shifted right by X86_CR3_LAM_U57_BIT or 0 if LAM
 =09 * disabled.
 =09 */
 =09u8 lam;
--=20
2.53.0


