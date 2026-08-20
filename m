Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407825228C;
	Thu, 20 Aug 2026 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787265022; cv=none; b=B1eyrGUJ64L8J6n2N+UqEXPcIpx6ZAKIHpsHmjtneLMDnyNMqqgRr5VNfnqNNeiQ1D4wp1uSlL0IlxBqw0e8iadBmfsi1KetT8dXVlPCFsFtuxli+ysz9wwXat5l+vMNtHxxMwIvmeAUYlPb8HHX3DGnGtdjcdpHNBLkZWppOgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787265022; c=relaxed/simple;
	bh=9IVGfvpGxkP0vr2gbL6ZbOF5DpFZaDyJ0NswEXUiMgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kvAo5eZyrL4qss9U9aWjK5fy1vxo4VT18a0MgWrsX0NoP4Dxv72CLR0hdj063fEEr/X4DkPlsAqpN4Byt3TA6K/UaHhSk8UtVDdGtsKBNjcJmhWvKNBTFFEaU8GNV5SS+CZgXhfYTrasCoOuWMuhMjKkU0aEqILkJjLZaOk1cAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=A8IrUFqB; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="A8IrUFqB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3uM/5Ah60/1yfTM9+Zuo8PO9yKPICs0GbkA7rgYWFfs=; b=A8IrUFqBb/LHNSAfvNi258Efpw
	k3gkshTlPpifnRaU4RVVWeOdx0+ttKHmb2QNCKgNyT1vqfzvuAQsWmv4nqiwoxMJDPtS8WsygoibJ
	LPcoHh6f+L8FV472rhqoYM5h2L8/FlMfFYMXUaQ0wK+oKruRN1nQy8Vp76kE20p8EysMg/z4xRXrm
	j5kuqtXJN7EzpKUaD2148VhRtpY9IJbWcFgKxdYlH4zdN2PXpSxVbaE9fWErWCxulxRAMqoXGA+tj
	5qVqOcg+XhuJUnLD0XDl5kfC67WvqQrbp/tZm7C5F14LkMzm6yRyimLho6FpirVzEmOy3t8vrxvDV
	B8ja3RWw==;
Received: from [151.115.150.205] (port=44086 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wxBH8-0000000Ahdt-3kQp;
	Fri, 21 Aug 2026 00:30:18 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: kees@kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] binfmt_elf_fdpic: reject PT_LOAD with filesz larger than memsz
Date: Thu, 20 Aug 2026 22:28:26 +0000
Message-ID: <20260820222824.3165092-3-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

The ELF specification requires p_filesz to be no larger than p_memsz for
PT_LOAD segments.

elf_fdpic_map_file_constdisp_on_uclinux() sizes its contiguous allocation
from p_memsz, then read_code() copies p_filesz bytes into it. A malformed
segment can therefore copy file contents past the allocation on NOMMU
systems. The direct-mmap path also subtracts p_filesz from p_memsz without
first validating the relationship.

Validate every PT_LOAD immediately after fetching the program headers.
This covers both executable and interpreter headers before
begin_new_exec() makes execution irreversible.

On RV32 NOMMU, an ET_DYN with an 8192-byte p_filesz and 4096-byte p_memsz
copied a marker from the second file page past its one-page mapping.
After this change execve() rejects it with -EINVAL, while an 8192/8192
control still executes.

The flaw dates back to the driver's introduction in the pre-git history
tree introduced in v2.6.11 by 91808d6ebe39 ("[PATCH] FRV: Add FDPIC ELF
binary format driver").

Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 fs/binfmt_elf_fdpic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 068c46875c74..e8a6e89b76a0 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -157,6 +157,12 @@ static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params,
 	if (unlikely(retval != size))
 		return retval < 0 ? retval : -ENOEXEC;
 
+	phdr = params->phdrs;
+	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
+		if (phdr->p_type == PT_LOAD && phdr->p_filesz > phdr->p_memsz)
+			return -EINVAL;
+	}
+
 	/* determine stack size for this binary */
 	phdr = params->phdrs;
 	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
-- 
2.47.3

