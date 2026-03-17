Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0982135D7;
	Tue, 17 Mar 2026 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759622; cv=none; b=mQoD8sr1GNNyUfHdpETIaWyYX1AyCajrlyhQioyfo5bIuwFsAKUrOh0T+Z5GUniGTAJhcxR1czUJ9iAMFaI/UzNZd4yigKMFmipkXWxI4ws+mi1TG0/7LlXx51wCPzRuNt+bzczkGebjdz/7Qk3EMW/NzNe3v+PwGVKxhhVJTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759622; c=relaxed/simple;
	bh=7bxS4LU9tfMf2a4Zwm/TJ0vz9K0WzeizQNm85TnHUn8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PEgnrUMOpi3IGukbEcCjf52nkPXhY7yX3wqiNkwCz6NIIVl53euMye4M2WrVQnsyafxf0hdyQaUmB9tfnpCcmSdJiUhRYkF84Tsq5KIqfzjSiceCt4RC0tZ0SfJFu3LNY7S2NFyGmDWGCV+AVYvzIoi4gSeUx0kuABil/H3+t90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EB8C1477;
	Tue, 17 Mar 2026 08:00:12 -0700 (PDT)
Received: from NH27D9T0LF (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 719AC3F7BD;
	Tue, 17 Mar 2026 08:00:17 -0700 (PDT)
Date: Tue, 17 Mar 2026 16:00:06 +0100
From: Emanuele Rocca <emanuele.rocca@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] coredump: add core_pattern specifier for si_code
Message-ID: <ablsdmLsMKm0z5wt@NH27D9T0LF>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The specifiers supported by core_pattern include the option to indicate the
signal number si_signo by using %s. Other than identifying which signal
generated a core dump (eg: 11 for SIGSEGV), it is useful to know the reason why
a certain signal was sent. The signal code si_code (eg: 2 for SEGV_ACCERR)
provides this information.

Adding the signal code to core_pattern can benefit in particular sysadmins who
pipe core dumps to user-space programs for later analysis. systemd-coredump(8)
is a notable example of such programs.

Signed-off-by: Emanuele Rocca <emanuele.rocca@arm.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 1 +
 fs/coredump.c                               | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 9aed74e65cf4..20177bd94514 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -170,6 +170,7 @@ core_pattern
 	%d		dump mode, matches ``PR_SET_DUMPABLE`` and
 			``/proc/sys/fs/suid_dumpable``
 	%s		signal number
+	%n		signal code
 	%t		UNIX time of dump
 	%h		hostname
 	%e		executable filename (may be shortened, could be changed by prctl etc)
diff --git a/fs/coredump.c b/fs/coredump.c
index 29df8aa19e2e..e78a889fe34c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -400,6 +400,11 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 				err = cn_printf(cn, "%d",
 						cprm->siginfo->si_signo);
 				break;
+			/* code of the signal that caused the coredump */
+			case 'n':
+				err = cn_printf(cn, "%d",
+						cprm->siginfo->si_code);
+				break;
 			/* UNIX time of coredump */
 			case 't': {
 				time64_t time;
-- 
2.47.3

