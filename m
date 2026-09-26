Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B434B697;
	Sat, 26 Sep 2026 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439796; cv=none; b=njYNqbBNDKQTRPxo23YmDW2bDONDucCB2nHEc2dJr/xIoqBIYrkuwcWfgyYvooSEH4pv91Cbl1eVT35RK6ssk0f2OEWNTyFMp4iizUGDdp5ldfC1xpZ0tHcsBmtNkpd/b6svWaw8FRA01nPHR98xo+1JJBQ7QhHL5gdbpg2USI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439796; c=relaxed/simple;
	bh=lVuH7qFpWQH76wp5FacuT3Zzo8joo8v3gTOUy+KtMmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVqvAEWaxzMw2nrhxw5kxpXA5FS4AJdreIOK0Am3LlXk1Bp5ZR+OClxdfMrCXXP16LfJLCHCgq6olkoGJ+ASs2qvE6K+Y+obdnHQmTh4hoOSToC8b/H+cW6/4D0dNiWVafKb+lFYTNeBHjOfsLU4ldG6xm2gOfOKxyb1Ad9qOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGeuNtS0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGeuNtS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C491F000FF;
	Sat, 26 Sep 2026 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790439794;
	bh=fl5lmGyMF1RWdAgtrF9R0uo85iRNCTQENGpIYhpXamg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HGeuNtS0QJpllq+JO2OxkZGnRkmpNGJFsit95JoS8a7pt6sb6pPRLCWx5bcsPo2Fd
	 1HTjXzsJmxRXdjXAnyDFzbEHKE5jWoQhyJ4OxUNWPS9QTSCIIpI3YmSmFXXp//wiox
	 36kvbk7c/WJVUWqnxFf34b7ZnFTpuv5qXsAp76/HJ8GC7UvhrNRrWTSIdL6qgQXLCz
	 tzU41b/dDETyRqGgV6utNNNM2kjRvQc4/EZ3WjtvfFz8ytM9TodhMmsblxykCnfVoa
	 tYE8W4VeOcqd7eQQ5mlJXWy5WcbFLO/kWbbCUDViC5eqaD+LtkEprMONbA5NSbKxry
	 5SjeGnkjwPIwQ==
From: Alexey Gladkov <legion@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Serge Hallyn <serge@hallyn.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/5] sysctl: add typed field descriptors
Date: Sat, 26 Sep 2026 18:22:07 +0200
Message-ID: <cover.1790439358.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789987960.git.legion@kernel.org>
References: <cover.1789987960.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Some sysctl users copy an otherwise static ctl_table for each namespace or
device, then replace data and limit pointers before registration. Besides
the per-instance allocation, these fixups often depend on table indices:
reordering an entry without updating the fixup can silently bind it to the
wrong data or limits.

This series lets such users describe a table once with static, read-only
sysctl_field entries. Each field names a data type and an offset into an
object selected by a sysctl_context at registration time. The offset
helpers check the member type at build time. Limits and custom handlers
remain optional properties of a field; the field type does not encode a
choice of handler or whether limits are present. A subsystem that needs
more than a namespace can embed sysctl_context in its own registration
context.

The sysctl core keeps the context with the table header and materializes
a ctl_table entry when an existing handler, permission check or BPF hook
needs one. Legacy ctl_table registrations retain their own path, and
subsystems can convert tables independently. The IPC, mqueue and ucount
conversions here remove table copies without changing their backing data.

Changes since v2:

- Drop sysctl_uint_vals, as requested by Joel. Existing limit constants
  suffice for these conversions.
- Drop the *_MINMAX field types. A field's type now describes its data,
  while optional min/max pointers supply bounds to the selected handler.
- Keep __register_sysctl_table() and __register_sysctl_fields() as separate
  registration paths, sharing only allocation and tree insertion helpers.
- Address the sashiko findings: avoid calling mode_fn under sysctl_lock,
  validate the effective maxlen against the context object, and reject
  NO_DATA fields paired with standard handlers that require data.

This is the first part of the conversion. Network sysctls and other
subsystem-specific users will follow in separate series for review by
their maintainers.


Alexey Gladkov (5):
  proc: sysctl: address table entries by index
  sysctl: add typed field descriptors
  sysctl: ipc: use typed fields for IPC namespace sysctls
  sysctl: mq: use typed fields for IPC namespace sysctls
  sysctl: use typed fields for ucount limits

 fs/proc/inode.c        |   2 +-
 fs/proc/internal.h     |   2 +-
 fs/proc/proc_sysctl.c  | 681 +++++++++++++++++++++++++++++------------
 include/linux/sysctl.h | 138 ++++++++-
 ipc/ipc_sysctl.c       | 189 +++++-------
 ipc/mq_sysctl.c        | 104 +++----
 kernel/ucount.c        |  64 ++--
 7 files changed, 772 insertions(+), 408 deletions(-)


base-commit: 587858367581b9c55c3690f4e63382ad622719d4
-- 
2.55.0

