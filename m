Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633073B6356;
	Wed,  1 Jul 2026 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921296; cv=none; b=bcCiPTGiB91OV8yoSQA7o45PPkHReBoZqi5sGUHERPrj/BMC4uOP/VJ1XB89TpwqNbII+bErd84o/DI7w1w/4tX5kjpvNVI0DSFrSaf6SqRiMI6hBNNaCEs4pyolGCws7rRDNAdyuv8coeoM1etx7ToFMpXOZnAGAP+Y2vIFfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921296; c=relaxed/simple;
	bh=tZN5BEfBoavXRRM94u2PuTwu4kGEGBB9JlN2ujo3H80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZHO76hxY0uKNZCouWvv3d4BWcCrvg5+BkT8Oow2YbNJQHlVX1qfTFJRQZmg9KaBzBDIocH84vRBhZdTxA0FnS+rnc1pL80VsmbcMxg3jgrKtw5sGgponQlSgs4ek0Qadk8LWIIYkSE6a9on20BL7ICNVkjgMYEF1syw/bL9DFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya+FHeX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya+FHeX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD2D1F000E9;
	Wed,  1 Jul 2026 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782921295;
	bh=uGKyssi0eVeZW3I4gfPxkqGigKf11zHwFf2pYy0UaDA=;
	h=From:Date:Subject:To:Cc;
	b=Ya+FHeX0lG9FjzqtCg18N3+yaXDOZDAV0TQ2aupcuDfyxAeZ+hGUhVimYViC/Cj7W
	 qWzpRsGbLBZ6/s4Zk6Xxiax3osR7TYyoLSljLlCm8ABqzO+K0tfPbCZP3cmIdVB1Im
	 gJEdV2M2KLVqRlW2wFtMCuUbu/40h6sddeg4CIlk211UY3TgwOXK8YMVIskzcvb41z
	 S2zbNn7rvgNCx1F4pBTusdFYPLKbbHK0RIc86zWPXjZkYqL+1yl3QwxmGL7xYCx91s
	 dDfdGoCpVIDpunOiRu5nyWuN/BvdP3XHw/V1ZkhhEJD6RkEtC5vFzqIlxWnIRa+ZRF
	 c8U4iFug/ysnw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 01 Jul 2026 17:54:48 +0200
Subject: [PATCH RFC] coding-assistants: simplify attribution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEc4RWoC/yWMQQ6CQAxFr0K6tmSGREjcmngAt8ZFGSpU40DaE
 U0Id3fQ5Xt5/y9grMIGh2IB5VlMxpjB7woIA8WeUbrMULmqdo3z+B71gWHsJPZIZmKJYjKs947
 Y54rZQR5Pyjf5/I4vcD4d4fqX9mrvHNJ2uWUtGWOrFMOwqSdZYi3npqxQg4d1/QLNpcmWoQAAA
 A==
X-Change-ID: 20260701-work-coding-assistants-650ae1202ee0
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Jens Axboe <axboe@kernel.dk>, David Hildenbrand <david@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2774; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tZN5BEfBoavXRRM94u2PuTwu4kGEGBB9JlN2ujo3H80=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5Wvg8/b303Ps/yiem3ti1M8ancZGbkP+Kjovl036Gx
 oqHSd192FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRLH5GhgPay1KrXs+KqNWI
 qFrPNHHNSr4O1zdMvmbC/p95ZzA1RTH8z/xqESgiMNnM60CB78vVWt8e6SSv+7o/6kB00mHN046
 /GAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

I remain very confused by our coding assistant contribution guidelines.
I'm going to be a bit polemic now but this seriously in good faith.

Why precisely do we require all this detailed information about what
specific coding assistant was used?

I find it very irritating that our git history has effectively started
to function a bit like a free advertising platform for a bunch of AI
companies and their proprietary agents and models.

And it reamins unclear to me what exactly we do get out of this detailed
information: Do we want to run statistical analysis on what agent and
model is used the most and publish that on LWN at some point?

I acknowledge that my stance is even more radical: imho we would just
stop it with any disclosure requirements completely. It's useless imho.
We already see that other than core contributors most people don't care
and will just not disclose their usage of AI. I think this is entirely
pointless and worse it brings in undefined legal status as well. It's
not like recent events of pulling certain models from the face of the
earth have made this any less concerning.

But fine, if we want to do this can we please just dumb it down to

Assisted-by: LLM

or

Assisted-by: Coding Assistant

or something else. That still gives the "careful review" signal to
reviewers that want to pay special attention to LLM generated work while
avoiding this slew of metadata.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/process/coding-assistants.rst | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
index 899f4459c52d..fe34f3e7e828 100644
--- a/Documentation/process/coding-assistants.rst
+++ b/Documentation/process/coding-assistants.rst
@@ -43,12 +43,8 @@ When AI tools contribute to kernel development, proper attribution
 helps track the evolving role of AI in the development process.
 Contributions should include an Assisted-by tag in the following format::
 
-  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
+  Assisted-by: LLM [TOOL1] [TOOL2]
 
-Where:
-
-* ``AGENT_NAME`` is the name of the AI tool or framework
-* ``MODEL_VERSION`` is the specific model version used
 * ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
   (e.g., coccinelle, sparse, smatch, clang-tidy)
 
@@ -56,4 +52,4 @@ Basic development tools (git, gcc, make, editors) should not be listed.
 
 Example::
 
-  Assisted-by: Claude:claude-3-opus coccinelle sparse
+  Assisted-by: LLM coccinelle sparse

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260701-work-coding-assistants-650ae1202ee0

