Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892736;
	b=1avO3gaFgsGPMIAWsNViCOmV0BVLrmcjb6y7v2nZxCDDozag3wFTY7mKpX1G9B74B7MA
	 J+jrseebSfpltVPGfSEN3XJaf23kGI2nmLQ28KG+qw6nIMwzoNNU4D/At0I4u5qgX8fds
	 aIMRfUd4G2xSkYwgxMwRYcOJ0FIycg7G7TQ6z+6zXVpC08n2RL6lX5FzyzBrJ/EIH5S7f
	 KmdIz+na3Km6mSZE3bV7aUXJn776RQhFWDfFq0woWCiYp2tnqYUvUQ6UVfMxfbcwJCLy8
	 8IPLEmhk0NrlC3S/fP7HLJzRVLXp9IVhmev/S99v+uUM1zkXrfgq6YNBIb68a2piyxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nNEmWFWOJH+6Qm1DMHENRRuucMRAFbZmaDLX/0UWzQk=;
	b=NnTanoxFARU/lh+A0/E82CC5VLNDERs0jYVLjbkvU9Q81V0zLOK28Bh0ArYwjAyjohF+
	 WpPi75c/OR7GHotEVVRs/znimyT2xapnYesLQhR0vRB9HdJbRkbKapkNqtj+8UUVrB69b
	 rgELozHwIJFDTod04H8NS7zloEJFF+N5o75KxEPiaUYS5l1tcCX3emZQp1HYhfY3Ub8s5
	 GNkTnkZuF6vu6RrEcO6nuNcf5jy5QY2F9lQjJulHTh7FXsyuW5mpSDpZaCZJtEyK9kmRQ
	 deGbZj0NsRB3O9GhVH96Ssidjf5vOjhxAw0wK3v+K5JUx+urtXwMlbmFkti1ncE1rJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="WIMfi/UZ";
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17877606A334
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17877606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=WIMfi/UZ
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7c03a445cb8so1263057137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892735; x=1794497535; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nNEmWFWOJH+6Qm1DMHENRRuucMRAFbZmaDLX/0UWzQk=;
        b=WIMfi/UZ1nzy4H9h1W7KOjHcaaN49NXXpVwtNRy5geigzX3WyH18lA7T4hOB6ntywy
         4AyakFJnzBEleZGcqr0zF5daigz12CAAhBl7qFwCyjn289BNq3u29gi4fKXvNn5r17w+
         rY+/Qkud4qz29NvFl/G3vWdJQGyAaFggo4v9LSTp1VqDBHA9pyGdszIFqlfo70z4xNrt
         f9M6jsN0SS+fYvs1rFz5h5T6Do5dZH/UmM5uzHPLEbmZ/ijGhJKOStc2PdWjp8fQi8e2
         5PcCXi6wqtESY4NHbbDi0kTy/aNIxJto/jj9MMm+aBbrfepVjObxN+Z7cjNsp+asasBL
         JMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892735; x=1794497535;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nNEmWFWOJH+6Qm1DMHENRRuucMRAFbZmaDLX/0UWzQk=;
        b=tdoizqKQNKX6gr8xiaxjxaNy5pPnbwIsJEyNsr9HSl/U14djYyVoI5WJ8jJI7hMiwu
         oYfGMcYKDl3ywhhCPxiVn0mwgnGZzATPxOcv+mDXO8oEjuUXXcGrhaCQMJNptJvox5fi
         ajXS7PGdFaMYpGgkIF9EIw1KyOyVxVFcvzCirpD5vNYEEWM3YLWuFfvgJBqlVmdWKaHA
         KnY++hshfji8Q9D9xZjeafyDcOa9OiAWieEAQdVrMqw11FPWmAnB5eWnSqX1OyxGcBf3
         pa9fxbhio9o8wzyV0sNpdVQ97it0nhPTn7RQNHqUePVNMBJoAT9JIC4YiCG9Fij+8mbT
         /H0w==
X-Gm-Message-State: APuU4Z9yM6UPr83mL1YZn336rml1e83pPxT7y+q6A72cTyGNaGg8mjls
	ERLodKI26J7DoBJQsgnG9cFnpnQBJ2CS8s5jXNU5R3RjmKfuXp53Dq1YTfarhTzmb0U=
X-Gm-Gg: AYBFou2CyJhIY6dxFlfWTmzpPOrz1ev4cSwZj0cdyyKKHB+27M1HIO2XegZZ8OJEEVW
	rKlw4Gj1QySonJRHsYrltagMZKJwWZ/wBg+ZkzAHrMmR1JX8D8tXMhDjB4vGYzHKnzckWaVzcyS
	8NvpYyFV7zqpICxgS9akhHV6H0doxb72q3OrIrdwgjzAE7pgBRU7V0JGJtTxEU+CzSwiKQ0GcvY
	g7LmT/abwNw5Qe5DfVheCjBNXg5cRuB3B3+2khqn2sne7A+2j/YTCy1LczP1ZvoYPL7Fcq+6qOe
	zdotXbolg/uIcSCsVDHvCliUsMc842JFxa9oSFHLnEE/rafdau8umS17hnvrKDdXBOmPxrtbi59
	LpAz0FI6bpg+I8HqT2/5p652oQqrKFhR2+K4ArEoXVqb+RVD1+LKX7HFRpKX1VgnQJaRWPWeo5C
	NN3h7LHqZx6iPi864aopr/g82v1ZGZXz2mz2998NNA0KSretTK/A6xmK7j1EUCfth000DiCs1nS
	nmRo/pNBsYWsmSDqvCEJahQY7X+pDiZmganj3LhtCoCYsNar87fVx1W5ZWTrrorRyrF5ML4Qf8a
	1U97r90JgY4Bk0IfGyo/Y5ddrYNK9o7OnHIuAg8aoF5O
X-Received: by 2002:a05:6102:3e85:b0:7cc:306:d3ab with SMTP id ada2fe7eead31-7d07277bbc5mr9885732137.5.1793892734983;
        Thu, 05 Nov 2026 07:32:14 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfe973bsm49902466d6.22.2026.11.05.07.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:32:13 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:19 +0000
Subject: [PATCH RFC v3 87/90] cells: add CONFIG_CELLS
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-87-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890936; l=1981;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=QnStMcDyiDaV1vMhCiMKcNfrXjeRKepI1Ga9lr0Q4UQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEBQjgBSgsAQ1k0wjhPj33XlLy5TcRZ8m4oVX8IprpyWHvV75ZwRovZGBtgxoxBD+OoXClTvc5I
 JlJOA+ViIgwI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Everything is in place now. Add the config symbol, and build kernel/cell/,
kernel/embryo.c and fs/cellfs.c if it is set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/Makefile     |  2 ++
 init/Kconfig    | 16 ++++++++++++++++
 kernel/Makefile |  1 +
 3 files changed, 19 insertions(+)

diff --git a/fs/Makefile b/fs/Makefile
index 16f1108b64e1..6a15893003e3 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -127,3 +127,5 @@ obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
 obj-$(CONFIG_BPF_LSM)		+= bpf_fs_kfuncs.o
 obj-$(CONFIG_RESCTRL_FS)	+= resctrl/
+
+obj-$(CONFIG_CELLS)		+= cellfs.o
diff --git a/init/Kconfig b/init/Kconfig
index 4013781e0a02..78690b74e6cb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1264,6 +1264,22 @@ config USER_NS_MAP_KUNIT_TEST
 
 	  If unsure, say N.
 
+config CELLS
+	bool "Cells"
+	depends on USER_NS && PID_NS && NET_NS && IPC_NS && UTS_NS && CGROUPS
+	depends on UNIX
+	help
+	  A cell is a container as one kernel object. It is built from the
+	  outside by filling slots from file descriptors, sealed, and has
+	  tasks spawned into it. A task never changes cell and nothing can
+	  enter one.
+
+	  This reserves the upper half of the uid and gid space for the
+	  kernel to hand out to cells: with it enabled no file on a filesystem
+	  of the host can be given to an id from 2147483648 to 4294901759.
+
+	  If unsure, say N.
+
 config PID_NS
 	bool "PID Namespaces"
 	default y
diff --git a/kernel/Makefile b/kernel/Makefile
index da712b4399ff..ba60039affdb 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
 obj-$(CONFIG_UTS_NS) += utsname.o
 obj-$(CONFIG_USER_NS) += user_namespace.o
+obj-$(CONFIG_CELLS) += cell/ embryo.o
 obj-$(CONFIG_PID_NS) += pid_namespace.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKHEADERS) += kheaders.o

-- 
2.55.0

