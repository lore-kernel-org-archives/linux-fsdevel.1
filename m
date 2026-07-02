Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19FB4949FF;
	Thu,  2 Jul 2026 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002798; cv=none; b=Me3/X7KKqNWKAsrp96N23iIdzMx4wW72GR7QeE9qLGlrfBhl4A0XDrPuibJe66iALamywBx02v3PhrH3b533YjeR+U0YbhsO0VIIw9SKaYVzfxUPE66OteLUwJCg9y6cHVyEbZoF2DWQLsPDM9eBUoH4I/nL0DXGs9YYg4g5UWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002798; c=relaxed/simple;
	bh=VwALL1CLa3MHOZPyhYCPHFevCXfXeLWPcPMyfYsJl/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ifnQwCeBBc5SzKKwVo+3bSfKsv9sgPRAtt5sCmonhM+wFndc9iCVJZVkvJ2DuS26Zm5SNAwY+jG0KUaaN9x2ud55GoyFvQzPV3IKT1TpX3zjJ1nJRkxyDz2X9dzeiI0JDj7mt+LtZ2o5haE1XLQM8HVOnzPJfzXR/b3cyGvjLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsgETONb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsgETONb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BAF1F000E9;
	Thu,  2 Jul 2026 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783002793;
	bh=WrG0OcwOEgURZ4WYdMBRYNJ5EzkU3zUGs20P0YcxiIM=;
	h=From:Date:Subject:To:Cc;
	b=EsgETONbu4Lf13kgKceGuPUwlW5Jop5gl7AkievMhu/qFGpHR3L9zpPvqzaWHJrPl
	 WCWqXv0HEDxDIpSfhVE0e/6XiC/24YH7fBA2TnrArkajO5v+pEqNkESWw0vqqz0BZv
	 E40rRn/ID4qgmmt3rrAoyuIDip2vNgYxEAGbquhWMbLk1J5IE9EBL4Il8ZN0aUKFYu
	 J7i3S1Vx5Ie5Yb5ljauF4C1UR9cs0LS9wCMMWSv/c7CNnx/wsHMPYV3UxMZuaVXbOc
	 PZK6V2Qa4UMHp52H7RuyJLkkWvGMJx65XkWPZ6RsDU14TDplp6r+JQlNkzJEb6EfRh
	 7TuNzx4jmfn7w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 02 Jul 2026 10:32:48 -0400
Subject: [PATCH] Documentation: remove the requirement for LLM attribution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwMj3cTMlPxkXfNUQ4s0IyPDFDPjRCWg2oKi1LTMCrA50bG1tQA60Uk
 AVwAAAA==
X-Change-ID: 20260702-aidoc-7e18f221d63a
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
 David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>, 
 Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>, 
 David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VwALL1CLa3MHOZPyhYCPHFevCXfXeLWPcPMyfYsJl/8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqRnai/gKXOrwEHaJip75IM/d38JKS5kmCb/eoy
 NT66RC0KhKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCakZ2ogAKCRAADmhBGVaC
 FXJDEACeLv7UX7B+3MkvQeF7XtMmdwNJANt7yElsGT0Hq2pQLLrHjN6IiUg4aphBS2wSbKp3Evv
 FQyzZqj/OJBE1ZzoLhqNyCWqqWu7yFZ2n2eLwJO6Y4jgOL0sBZDL9BBvhkFlOeLjE0GPopFgP5z
 VrG41+oHi51Gn/8GdoypLNKoBzBSm0IIs0+uz/dXJpxT270KnpK6mwXGtKyt7no1N0lcyOPIPJm
 KXqZ2qnViDQPxqNx00sT9m45qVjsh+UludTVuHqvcBFNLYSMg9AhakAc3gTxpWsXCBhT1uEp683
 lLG0AE/xNOGUa7QF6BYYtWuRtJsvzj/tj8s+9i4pMqhyACNJoDStE6OfgoeivTgiVGs/JfcXtvi
 XruNCq9whl9ziCYa1nnnSCFJShLzxYEezF97z9cCb3zK7dOCt6LPl6c0vU665i1WLisOwuxKYr2
 56mH2oPSwI1tXbdbwM8pQNRQVb9LdoArZL7/AYjsVL1uzCMwtulHC+Xgs7iXK6fVQg9BPwfTzFv
 HiRyq+f5nX+fTGg48T6SElmcTRzcKfkxq6dy+NZhQl3mBJhxPLJwHOx1pShgvrIZNF1sK4u1yZm
 z01e5JBCmxCRBE/dq2vbfMngJReVnTBIe9BN3bunKeFXy4WUSgpGgw0bccG+bkvhmreDDmmRGFc
 ZVXBV3x5Pu5xcnA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We've had this requirement in place in the Documentation for several
months, but it's becoming clear that the signal to noise ratio from this
is quite low.

1/ It's not universally followed. While many people do try to attribute
the LLMs in good faith, not everyone does for various reasons.

2/ It basically serves as free advertising for proprietary LLM companies.

3/ It's not clear why we want to collect this info in the first place.

Given that the data this provides is flawed at best and is being
collected for a purpose that isn't clear, let's just kill the
requirement for these tags from the kernel at large.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Christian had proposed watering down the LLM attribution, but I think
it's not productive to try and track this until we have a clearer sense
of what we want to do with this information and how to make it more
reliable.
---
 Documentation/process/coding-assistants.rst  | 22 ----------------------
 Documentation/process/submitting-patches.rst | 10 ----------
 2 files changed, 32 deletions(-)

diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
index 899f4459c52d..c4cc0917fc92 100644
--- a/Documentation/process/coding-assistants.rst
+++ b/Documentation/process/coding-assistants.rst
@@ -35,25 +35,3 @@ is responsible for:
 * Ensuring compliance with licensing requirements
 * Adding their own Signed-off-by tag to certify the DCO
 * Taking full responsibility for the contribution
-
-Attribution
-===========
-
-When AI tools contribute to kernel development, proper attribution
-helps track the evolving role of AI in the development process.
-Contributions should include an Assisted-by tag in the following format::
-
-  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
-
-Where:
-
-* ``AGENT_NAME`` is the name of the AI tool or framework
-* ``MODEL_VERSION`` is the specific model version used
-* ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
-  (e.g., coccinelle, sparse, smatch, clang-tidy)
-
-Basic development tools (git, gcc, make, editors) should not be listed.
-
-Example::
-
-  Assisted-by: Claude:claude-3-opus coccinelle sparse
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index cc6a1f73d7f2..b74c38aa9770 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -634,16 +634,6 @@ bugzilla.kernel.org is a public place in this sense, but email addresses
 used there are private; so do not expose them in tags, unless the person
 used them in earlier contributions.
 
-Using Assisted-by:
-------------------
-
-If you used any sort of advanced coding tool in the creation of your patch,
-you need to acknowledge that use by adding an Assisted-by tag.  Failure to
-do so may impede the acceptance of your work.  Please see
-Documentation/process/coding-assistants.rst for details regarding the
-acknowledgment of coding assistants.
-
-
 .. _the_canonical_patch_format:
 
 The canonical patch format

---
base-commit: 665159e246749578d4e4bfe106ee3b74edcdab18
change-id: 20260702-aidoc-7e18f221d63a

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

