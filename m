Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795873375;
	b=pD+lT437knoUwKyT/5WhSWrqfLQl+iDObEYIGTGR6D0iT9y6ynriz0EkHrnHe1ZwmuYz
	 BZuW4ml/MQiisGcEQcfGAUs3WZHxNGz0AULQYgO79cHPuQ5kU7kjr3tXGTSqkC6oEIO08
	 HYUGkIiaA4E7KaO+so5Qud32sUWFIuF40COJ58Ki9iDxRHufZ+cazJ+DN32cZ1D6g13u1
	 t3uuqgrx/nS0Ffy3vJ0vCAlb/soADCqnoy3SzuaVSbZsNiTfX9YsjBmibe32KZv9GNWom
	 lOixC3orSWZds3CAkyAbdlMFaI7t6IdZijSmvTa+QBP5xPqlRFYGHgnfQVi87pCrHDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795873375;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type;
	bh=ogMgdvQpGGoQmIF6CpJpsTzdhhvKznudi12MCR8DEy8=;
	b=UOxtRIko/d+PYC4kHhozNbFRumAotvCz/Jm4NkQGza5b+Q45mYey2LnqwCClmrXfesLa
	 nBZc38ns6r50bbIIjx2TJz3vrmoFugrzH8XMvH7Zztw922ovV3KDvlu6NKLPNCHbkGfTT
	 uzW7GdmuodMTZtrvIdV7a6nU2loR7f5Ww3x2Gz5w1MOtN0XnPduEu/0l+Y11HVVKsvtHA
	 LjpR/q75ro1EPX+hrFj6lBspPUd79Abmt3h3nffkYFpTdXckkVeYpn/RcXgNC0VHTgKOS
	 JhezVbSD3TWpOEkp/NQAonzjx/oQUrICsK4hQyinHPB3jUEksqX25TbGOCRaIpYk+yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mzfr.me;
	spf=pass smtp.mailfrom=mzfr.me;
	dkim=pass header.d=mzfr.me header.i=@mzfr.me header.a=rsa-sha256 header.s=protonmail2 header.b=LUdS3qqJ;
	arc=none smtp.remote-ip=185.70.43.20
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161E606A321;
	Sat, 28 Nov 2026 13:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F161E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mzfr.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mzfr.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mzfr.me header.i=@mzfr.me header.a=rsa-sha256 header.s=protonmail2 header.b=LUdS3qqJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mzfr.me;
	s=protonmail2; t=1795873372; x=1796132572;
	bh=ogMgdvQpGGoQmIF6CpJpsTzdhhvKznudi12MCR8DEy8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LUdS3qqJlFipr12kmswDnkSKIYZ7A3cK2SUWnofdd36XskWCc5V6/u5ymTS8XF6uh
	 WgNEHecJsk9n0KTLseA0t7Ul82TDmluqIRs+XnflrqZUhDzE+c3VD1NiZI1nCg462i
	 2wp2LqYjxXwK9KCOJwK7s23NxvgnKXSK9rVm8cCv1925NwD586VLJYfE6+XlCEJJBf
	 /A2gtEy4Ducqy44eoFP0/v8RduAMNKTvFz0VioPboK30o0cSvy5EwpjYcPrbc6g/mX
	 ndSb0WI82pCpjEU6LvutKnnHLkbP7Yr9LieV1ZAnCeqxvKHLrGoaE0ZCBGBnOniTlF
	 GHBXCTxGANY/A==
Date: Sat, 28 Nov 2026 13:42:48 +0000
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
From: Mehtab Zafar <hello@mzfr.me>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/splice: cover zero-count sendfile to a full pipe
Message-ID: <20261128134221.64884-3-hello@mzfr.me>
In-Reply-To: <20261128134221.64884-1-hello@mzfr.me>
References: <20261128134221.64884-1-hello@mzfr.me>
Feedback-ID: 37505322:user:proton
X-Pm-Message-ID: 451ce0ddd8f4fc2bd8b6b3926ba0e6b606190288
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------f76c3cbc752918eb2ddd3c2e8da20766fdcf629ed2a59e6cec25637707d44c07"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------f76c3cbc752918eb2ddd3c2e8da20766fdcf629ed2a59e6cec25637707d44c07
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Mehtab Zafar <hello@mzfr.me>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/splice: cover zero-count sendfile to a full pipe
Date: Sat, 28 Nov 2026 21:42:21 +0800
Message-ID: <20261128134221.64884-3-hello@mzfr.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261128134221.64884-1-hello@mzfr.me>
References: <20261128134221.64884-1-hello@mzfr.me>
MIME-Version: 1.0

Add blocking and nonblocking cases for sendfile() with count zero and
a full output pipe. Both calls must return zero without waiting for pipe
space.

This regression test was developed with AI assistance.

Signed-off-by: Mehtab Zafar <hello@mzfr.me>
---
The selftest passed 0/2 cases on baseline and 2/2 on the patched kernel
in each of three fresh x86_64 KVM boots per kernel. The static test binary
was built with warnings treated as errors; git diff --check was clean.
With the generic FILE_PATH_CHANGES message ignored, final strict
checkpatch reported no errors, warnings, or checks. Its final run also
logged an spdxcheck.py traceback because Python ply was missing; the
source and SPDX line were unchanged from the earlier successful SPDX
validation.

 tools/testing/selftests/splice/.gitignore     |  1 +
 tools/testing/selftests/splice/Makefile       |  1 +
 .../testing/selftests/splice/sendfile_zero.c  | 93 +++++++++++++++++++
 3 files changed, 95 insertions(+)
 cre
ate mode 100644 tools/testing/selftests/splice/sendfile_zero.c

diff --git a/tools/testing/selftests/splice/.gitignore b/tools/testing/selftests/splice/.gitignore
index be8266f5d04c..0b7414d3bbf1 100644
--- a/tools/testing/selftests/splice/.gitignore
+++ b/tools/testing/selftests/splice/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 default_file_splice_read
+sendfile_zero
 splice_read
diff --git a/tools/testing/selftests/splice/Makefile b/tools/testing/selftests/splice/Makefile
index 541cd826d5a5..b77c12767846 100644
--- a/tools/testing/selftests/splice/Makefile
+++ b/tools/testing/selftests/splice/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_PROGS := default_file_splice_read.sh short_splice_read.sh
+TEST_GEN_PROGS := sendfile_zero
 TEST_GEN_PROGS_EXTENDED := default_file_splice_read splice_read
 
 include ../lib.mk
diff --git a/tools/testing/selftests/splice/sendfile_zero.c b/tools/testing/selftests/splice/sendfile_zero
.c
new file mode 100644
index 000000000000..b597420be687
--- /dev/null
+++ b/tools/testing/selftests/splice/sendfile_zero.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/sendfile.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+FIXTURE(sendfile_zero) {
+	int input_fd;
+	int pipefd[2];
+};
+
+FIXTURE_SETUP(sendfile_zero)
+{
+	char path[] = "/tmp/sendfile_zero.XXXXXX";
+	char buf[4096] = {};
+	ssize_t ret;
+
+	self->input_fd = -1;
+	self->pipefd[0] = -1;
+	self->pipefd[1] = -1;
+
+	self->input_fd = mkstemp(path);
+	ASSERT_GE(self->input_fd, 0);
+	ASSERT_EQ(0, unlink(path));
+	ASSERT_EQ(1, write(self->input_fd, "x", 1));
+	ASSERT_EQ(0, lseek(self->input_fd, 0, SEEK_SET));
+
+	ASSERT_EQ(0, pipe2(self->pipefd, O_NONBLOCK));
+	while ((ret = write(self->pipefd[1], buf, sizeof(buf))) > 0)
+		;

+	ASSERT_EQ(-1, ret);
+	ASSERT_EQ(EAGAIN, errno);
+}
+
+FIXTURE_TEARDOWN(sendfile_zero)
+{
+	if (self->pipefd[0] >= 0)
+		close(self->pipefd[0]);
+	if (self->pipefd[1] >= 0)
+		close(self->pipefd[1]);
+	if (self->input_fd >= 0)
+		close(self->input_fd);
+}
+
+TEST_F(sendfile_zero, nonblocking_full_pipe)
+{
+	off_t offset = 0;
+	ssize_t ret;
+
+	ret = sendfile(self->pipefd[1], self->input_fd, &offset, 0);
+	ASSERT_EQ(0, ret) TH_LOG("sendfile: %s", strerror(errno));
+	ASSERT_EQ(0, offset);
+}
+
+static void alarm_handler(int signal)
+{
+	(void)signal;
+}
+
+TEST_F(sendfile_zero, blocking_full_pipe)
+{
+	struct sigaction action = {
+		.sa_handler = alarm_handler,
+	};
+	struct sigaction old_action;
+	off_t offset = 0;
+	ssize_t ret;
+	int error;
+	int flags;
+
+	flags = fcntl(self->pipefd[1], F_GETFL);
+	ASSERT_GE(flags, 0);
+	ASSERT_EQ(0, fcntl(self->pipefd[1], F_SETFL,
+			   flags & ~O_NONBLOCK));
+	ASSERT_EQ(0, sigaction(SIGALRM, &action, &
old_action));
+
+	alarm(1);
+	ret = sendfile(self->pipefd[1], self->input_fd, &offset, 0);
+	error = errno;
+	alarm(0);
+	ASSERT_EQ(0, sigaction(SIGALRM, &old_action, NULL));
+
+	ASSERT_EQ(0, ret) TH_LOG("sendfile: %s", strerror(error));
+	ASSERT_EQ(0, offset);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


--------f76c3cbc752918eb2ddd3c2e8da20766fdcf629ed2a59e6cec25637707d44c07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wsCpBAEBCABdBYJrCtpYCRBCkCzGpVLSJDUUAAAAAAAcABBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3JnMPcH3sFolW/lVvgwPO2jiRYhBJC8NTVod5IV
Rdc7/kKQLMalUtIkAACb7Af+Mqu5aPcpErgXgpPrmplUbYv+wVrTzeoKnapx
f45DpNrLhBAETtQRDhwhad/u/jL9A95hw4zNjnShnLh02nNJpfphBbTY8Vqs
TC9pyHb96cJyKg60xJytEx/f+zEFp0ztJswUuwdI6x8UfWmCkOAaiBhUeYZA
YeYHcIl28eUbmgsLumFS3va46ZpzBjrfs3sec+e44Pl6Ow7TBh3YdB/0JlSK
zI52B2OkPyLVVraCb8tj4OiJk5pAvA5ACcIwdFcpqb9W4VzOaIf+LsWMDvvf
h6ontkwmMRt/NaGaQA6Od8buQRfmsGp43LsJDW2w3xJhV5ZTzyJN5ZEgOruI
GO0w2g==
=YIv+
-----END PGP SIGNATURE-----


--------f76c3cbc752918eb2ddd3c2e8da20766fdcf629ed2a59e6cec25637707d44c07--

