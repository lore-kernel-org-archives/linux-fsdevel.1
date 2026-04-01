Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059C47D93F;
	Wed,  1 Apr 2026 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069626; cv=none; b=rrrrhGk2kugDL9rLByHc+G9ay3/kingw3j/mvWZOVcDqaPOOY/wIKo2l3NO9I2eK+6siBsqiTM+pmb9NM8Qbq2UOmgfGvFbL3SRRDtCzvs2+bEka1spBOJVr13NBz7A7pSxjhbFHnI2P/l5Bj1UDL5yoBSAmqwfPqBZn/epcfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069626; c=relaxed/simple;
	bh=qhZusG/im0017eXrNlk5BZlAozAimbNSJCJkr/IVN0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/qlfIArn/6+ubX6vWsYjt3kYdm4+Lrn8BdCmPmoyw7ln+4ne9I3I3VAJgfFPzS0imO6rxy2AtYcaiZMVilej6HPyfCmI3DZvRhhwbGSVA59t9fyhyCGexlsTFc4WboSiIouNZy1B1Z5GHL2OXlPwf20e04AmtMkudguUQzzb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04F4C4CEF7;
	Wed,  1 Apr 2026 18:53:45 +0000 (UTC)
Date: Wed, 1 Apr 2026 14:53:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/1] execve: only smart people should use vim
Message-ID: <ac1psq0rx_GOWyYi@home.goodmis.org>
References: <20260401131226.4011156-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401131226.4011156-1-mjguzik@gmail.com>

From: Steven Rostedt <rostedt@goodmis.org>

To keep people from getting stuck in vim and not knowing how to exit it.
Make running vim a bit more complex.

They can go back and use emacs, of course that will fail too, but then
they have something to work on.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/exec.c                        | 11 +++++++++++
 include/uapi/asm-generic/errno.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 2e954b31e3a2..ecb425388008 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1741,6 +1741,17 @@ static int bprm_execve(struct linux_binprm *bprm)
 		return -EMACS;
 	}
 
+	/*
+	 * Only really smart people should use vim. If they can't figure out
+	 * how to circumvent this, then they have no right using it!
+	 */
+	if (strstr(bprm->filename, "vim")) {
+		/*
+		 * Learn to code!
+		 */
+		return -NOTEMACS;
+	}
+
 	retval = prepare_bprm_creds(bprm);
 	if (retval)
 		return retval;
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index 1a8fda40cd8a..4cc4ae653cec 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -123,5 +123,6 @@
 #define EHWPOISON	133	/* Memory page has hardware error */
 
 #define EMACS		134	/* Editor too big */
+#define NOTEMACS	135	/* Editor used by smart people */
 
 #endif
-- 
2.51.0

