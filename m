Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4383CEBA9;
	Thu, 20 Aug 2026 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259139; cv=none; b=hFlG6Ix8Cc+PABYgFRMusbBjmtKmFcBfiiwFrCQv6iK9PoGsM7f4ujWWlPThyHyw5giLclVWXs45XCAT6pN3F02xkeC/PZObg3uHMKyt6otnk8LY74NoVJRSScBrIz8A3VCx8IQGfR78woQYHCjOmN3v2fRGDqjP93kYyra9PnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259139; c=relaxed/simple;
	bh=QIopnmQCaQij3r1lch9mvlJPgX2fa26jwKUtW9GHgXs=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=DrAP+ZBB0b+frcpgOStuQnFV483WWTVxZDuB1tTS+Y11n7CUNVWFjczVBXpqA+p+MK04BGmVTQnc6xkUojFhrKoy5f00PDR3z5hFRnnWEHJHESj0MuqLDEu+H00dcSQC9/rchgNLIDfW8ix1nBNkIIZfe2FIYT8kHpQ3OBLhPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=u61ccTh+; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="u61ccTh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787259127;
	bh=AE6r0FUCPJ7x9EVCuvUQE/HyswfGiR3qlwFQ5NnL85k=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=u61ccTh+alTHJJeznHz0wB33p8pYww4mO8+vMbS1vcKuIxWhOY7gPOxtlZZXlQR4T
	 xAL7OE33t0FQ54N3OPlWT79txpHS9O3A8FPj95rdoDRAlliyw0j6tKLmzui7PNGtrF
	 OuKMJnTCVpKBFFbmsi2PNh+nL2ThkTbuHG6Harq8=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hQwbq3YCWzGpBp;
	Thu, 20 Aug 2026 20:52:07 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hQwbq1YxqzGpB7;
	Thu, 20 Aug 2026 20:52:07 +0000 (UTC)
Date: Thu, 20 Aug 2026 21:52:08 +0100
From: Bradley Morgan <include@grrlz.net>
To: rgb@redhat.com
CC: audit@vger.kernel.org, eparis@parisplace.org,
 linux-audit@lists.linux-audit.osci.io, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul@paul-moore.com, rmd4work@mail.ru,
 rrobaina@redhat.com, sgrubb@redhat.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_audit=3A_free_proctitle_in_conte?=
 =?US-ASCII?Q?xt_so_it_can_be_re-set_by_fork_on_exec=5Fbinprm?=
In-Reply-To: <ef5bf18a4b3805ec0fe5fb638963ccbdfc01d6fe.1787077711.git.rgb@redhat.com>
Message-ID: <78CB3D31-145E-461F-9E00-C4CA1CEAF701@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 18 August 2026 19:28:53 BST, Richard Guy Briggs <rgb@redhat.com> wrote:
>Between the actual process startup (fork systemd) and the executable file
>replacement (exec), systemd sets a temporary file name (executable file
>name in parentheses). If an auditable system call occurs at this point,
>the audit context will latch the temporary process name into the cache.
>This name will not change again. The patch clears proctitle into the
>audit cache when the exec call is made, allowing the new process name to
>be latched.
>
>Suggested-by: Roman Dolgikh <rmd4work@mail.ru>
>Link: https://github.com/user-attachments/files/20751461/fix_audit_proctitle.txt
>Link: https://github.com/linux-audit/audit-kernel/issues/170
>Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

LGTM, cheers

Reviewed-by: Bradley Morgan <include@grrlz.net>



>Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
>---
> kernel/auditsc.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>index 2b9ce0b52511..ee7e53d2cd52 100644
>--- a/kernel/auditsc.c
>+++ b/kernel/auditsc.c
>@@ -2601,6 +2601,8 @@ void __audit_bprm(struct linux_binprm *bprm)
> {
> 	struct audit_context *context = audit_context();
> 
>+	/* clear proctitle in audit context to allow replacement */
>+	audit_proctitle_free(context);
> 	context->type = AUDIT_EXECVE;
> 	context->execve.argc = bprm->argc;
> }
>

Thanks!
