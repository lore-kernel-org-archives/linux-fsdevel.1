Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F847DF90;
	Fri, 11 Sep 2026 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131552; cv=none; b=hYjdMxMHipyP6qw3yUoWOCKVjbb+HDjXTWaBjFyzVP3Db8H3suifBMxwMP0OvFuIkNrc5qHAaH25bSgoH8L34FWoyEevdJobyOQJ/+pnWj/LezML4kSeQf42dysf+cMWnDNLhMn0p6OWvI78n8wXhrZHrGovWkrZUgAW8mLBeKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131552; c=relaxed/simple;
	bh=IVo2L+I/fkh6l362FV8nWKtvbhyFH6GF9aN5+o3+XuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyYAyJSSjYqwY0SKKcvTmZ6geKmkojPJcHiOMz4VMQckH/s879Uji96CmwpctQXLF1JZifqyqv2yXM7CE9cmrhKsi0i0dyr7NWtj9/RaQwwIP0M8vMNVIAtsbIFXhF4uE+YaD6YHotOZH/T8diUGwrx2XvoRGCHjjDAjKBJ5VEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV+sBLLQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV+sBLLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3831F000FF;
	Fri, 11 Sep 2026 12:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131542;
	bh=obY9T9rOkh1/3EUb3FQ0mH6hQECuL7GUAna9UeGCXEs=;
	h=From:To:Cc:Subject:Date;
	b=kV+sBLLQiwgF8OGg5h002JQVOp450Gi04gsDHU4EETU2/yFV33OKbhBbc55u4QBU3
	 NFZ0YdwZlFl7d/OCwCNy/nuLY0E9MTVPxhcmh8szqh+qpw7cEG4UTeCrryacqBj3OM
	 oyueoP04urgtoUQlaDN7EJgIy/gvEIUNr8iHMtSkDaVg+9sEMxIFQnc0ARYbRZUHeT
	 3m04O5fnOp1Qkj5hmCWIS+L0/9OOx6MplvYxo55JsAZM4z4QVzHJNgWWbo/ltP9Iqt
	 MwCeYKKG8QUIJlxmuwa4u1/5hsxVX/5flcnWTLRNZj3CYudeQSj9fQP6OWkjLiWaNU
	 qj5bSid/1DGaw==
From: Christian Brauner <brauner@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Anand Moon <linux.amoon@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	kernel test robot <lkp@intel.com>,
	codemender-patching+linux@google.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] Minor bugfixes for kunit userns tests
Date: Fri, 11 Sep 2026 14:58:38 +0200
Message-ID: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=423; i=brauner@kernel.org; h=from:subject:message-id; bh=IVo2L+I/fkh6l362FV8nWKtvbhyFH6GF9aN5+o3+XuA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQt/s2oeyVvxx4ja5Gk1nscN0LCvTJf8y4JT+5Kd++8L pqg2XOyo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIT+RkZfj/Z+WDiq95HG2yv smWa7HqwetLBMx9FdFasF5NPffUq5wjDP2Utua7IDYLRZ//Mu/lhM4tcZsXfj5umTbwxRXCZToY 1Nz8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

two fixes for the kunit userns tests.

Christian Brauner (2):
  userns: rename insert_extent() and sort_idmaps()
  userns: declare the KUnit-visible helpers whenever KUnit is enabled

 include/linux/user_namespace.h   |  9 +++++----
 kernel/tests/user_ns_map_kunit.c |  6 +++---
 kernel/user_namespace.c          | 19 ++++++++++---------
 3 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.53.0

